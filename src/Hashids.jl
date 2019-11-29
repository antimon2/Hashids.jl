module Hashids

export encode, decode, encodehex, decodehex

using Base.Checked: mul_with_overflow, add_with_overflow

# const RATIO_SEPARATORS = 3.5
const RATIO_SEPARATORS = 7//2
const RATIO_GUARDS = 12
const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
const DEFAULT_SEPARATORS = "cfhistuCFHISTU"

_reorder!(list::Vector{Char}, salt::AbstractString) = _reorder!(list, collect(salt))
function _reorder!(list::Vector{Char}, salt)
    len_salt = length(salt)
    len_salt == 0 && return list

    integer_sum = 0
    index = 1
    for i in length(list):-1:2
        integer = Int(salt[index])
        integer_sum += integer
        j = mod1(integer + index + integer_sum, i - 1)
        list[i], list[j] = list[j], list[i]
        index = mod1(index + 1, len_salt)
    end

    list
end

"""
    Hashids.Configuration

Hashids' parameter-configuration.  
Be sure to place the instance as the 1st argument of [`encode`](@ref), [`decode`](@ref), [`encodehex`](@ref) and [`decodehex`](@ref). 

See also: [`configure`](@ref)
"""
struct Configuration
    salt::String
    min_length::Int
    alphabet::String
    guards::String
    separators::String
    function Configuration(salt::AbstractString, min_length::Int, alphabet::AbstractString)
        separators_list = [c for c = DEFAULT_SEPARATORS if c ∈ alphabet]
        alphabet_list = [c for c = unique(alphabet) if c ∉ separators_list && !isspace(c)]
        len_alphabet = length(alphabet_list)
        len_separators = length(separators_list)
        if len_alphabet + len_separators < 16
            throw(ArgumentError("Alphabet must contain at least 16 unique characters."))
        end
        _reorder!(separators_list, salt)
        min_separators = cld(len_alphabet, RATIO_SEPARATORS)
        number_of_missing_separators = min_separators - len_separators
        if number_of_missing_separators > 0
            append!(separators_list, alphabet_list[1:number_of_missing_separators])
            alphabet_list = alphabet_list[number_of_missing_separators + 1:end]
            len_alphabet = length(alphabet_list)
        end
        _reorder!(alphabet_list, salt)

        num_guards = cld(len_alphabet, RATIO_GUARDS)
        if len_alphabet < 3
            guards_list = separators_list[1:num_guards]
            separators_list = separators_list[num_guards + 1:end]
        else
            guards_list = alphabet_list[1:num_guards]
            alphabet_list = alphabet_list[num_guards + 1:end]
        end

        new(string(salt), max(min_length, 0), String(alphabet_list), String(guards_list), String(separators_list))
    end
end
Configuration(; salt::AbstractString = "", min_length::Int = 0, alphabet::AbstractString = DEFAULT_ALPHABET) = Configuration(salt, min_length, alphabet)

"""
    Hashids.configure()  
    Hashids.configure(salt)  
    Hashids.configure(salt="", min_length=0, alphabet=DEFAULT_ALPHABET)

Configure Hashids with parameters, and return [`Hashids.Configuration`](@ref) instance.  
`Hashids.configure()` returns default-configuration.

# Example
```julia-repl
julia> config = Hashids.configure();

julia> config = Hashids.configure("this is my salt");

julia> config = Hashids.configure(salt="this is another salt", min_length=16, alphabet="abcdefghijklmnopqrstuvwxyz");

```

See also: [`Configuration`](@ref)
"""
configure(salt) = Configuration(string(salt), 0, DEFAULT_ALPHABET)
configure(; kwargs...) = Configuration(; kwargs...)

function _hash(number, alphabet_list)
    alphabet_list[reverse(digits(number, base=length(alphabet_list))) .+ 1]
end

function _checked_muladd(x::T, y::Integer, z::Integer) where {T<:Integer}
    _checked_muladd(promote(x, y, z)...)::Union{T, Nothing}
end
function _checked_muladd(x::T, y::T, z::T) where {T<:Integer}
    xy, overflow = mul_with_overflow(x, y)
    overflow && return nothing
    result, overflow = add_with_overflow(xy, z)
    overflow && return nothing
    result
end
_checked_muladd(x::BigInt, y::Integer, z::Integer) = muladd(x, y, z)

_unhash(hashed, alphabet_list) = _checked_unhash(0, hashed, iterate(hashed), alphabet_list)
function _checked_unhash(number::I, hashed, hashed_status, alphabet_list) where {I <: Integer}
    len_alphabet = length(alphabet_list)
    while !isnothing(hashed_status)
        (character, st) = hashed_status
        position = findfirst(isequal(character), alphabet_list)
        isnothing(position) && return nothing
        _number = _checked_muladd(number, len_alphabet, position - 1)
        isnothing(_number) && return _checked_unhash(widen(number), hashed, hashed_status, alphabet_list)
        number = something(_number)
        hashed_status = iterate(hashed, st)
    end
    return number
end

function _ensure_length!(encoded, min_length, alphabet_list, guards, values_hash)
    len_guards = length(guards)
    guard_index = (values_hash + Int(encoded[1])) % len_guards
    pushfirst!(encoded, guards[guard_index + 1])

    if length(encoded) < min_length
        guard_index = (values_hash + Int(encoded[3])) % len_guards
        push!(encoded, guards[guard_index + 1])
    end

    alphabet_list = copy(alphabet_list)
    split_at = length(alphabet_list) ÷ 2
    while length(encoded) < min_length
        _reorder!(alphabet_list, copy(alphabet_list))
        append!(prepend!(encoded, alphabet_list[split_at+1:end]), alphabet_list[1:split_at])
        excess = length(encoded) - min_length
        if excess > 0
            from_index = excess ÷ 2
            # encoded = encoded[from_index+1:from_index+min_length]
            deleteat!(deleteat!(encoded, from_index+min_length+1:lastindex(encoded)), 1:from_index)
        end
    end
    return encoded
end

"""
    encode(config::Hashids.Configuration, values::Array{<:Integer})  
    encode(config::Hashids.Configuration, values::Integer...)

Encode the passed `values` to a hash.

# Example
```julia-repl
julia> encode(Hashids.configure(), 1, 2, 3)
"o2fXhV"

julia> encode(Hashids.configure(), [1, 2, 3])
"o2fXhV"

```
"""
encode(config::Configuration, values::Array{<:Integer}) = encode(config, values...)
function encode(config::Configuration, values::Vararg{Integer})
    alphabet_list = collect(config.alphabet)
    separators_list = collect(config.separators)
    salt_list = collect(config.salt)
    len_alphabet = length(alphabet_list)
    len_separators = length(separators_list)
    len_values = length(values)
    values_hash = sum(x % (i + 99) for (i, x) in enumerate(values))
    lottery = alphabet_list[values_hash % len_alphabet + 1]
    encoded = [lottery]

    for (i, value) in enumerate(values)
        alphabet_salt = [lottery; salt_list; alphabet_list][1:len_alphabet]
        _reorder!(alphabet_list, alphabet_salt)
        last = _hash(value, alphabet_list)
        append!(encoded, last)
        value %= Int(last[1]) + i - 1
        i < len_values && push!(encoded, separators_list[value % len_separators + 1])
    end
    if length(encoded) ≤ config.min_length
        _ensure_length!(encoded, config.min_length, alphabet_list, config.guards, values_hash)
    end
    return String(encoded)
end

"""
    decode(config::Hashids.Configuration, hashid::AbstractString)

Restore a numbers list from the passed `hashid`.

# Example
```julia-repl
julia> decode(Hashids.configure(), "o2fXhV")
3-element Array{Int64,1}:
 1
 2
 3

```
"""
function decode(config::Configuration, hashid::AbstractString)
    parts = split(hashid, in(config.guards))
    _hashid = 2 ≤ length(parts) ≤ 3 ? parts[2] : parts[1]
    length(_hashid) > 0 || return Integer[]
    
    lottery_char = _hashid[1]
    _hashid = _hashid[nextind(_hashid, 1):end]

    hash_parts = split(_hashid, in(config.separators))

    alphabet_list = collect(config.alphabet)
    len_alphabet = length(alphabet_list)
    salt_list = collect(config.salt)
    numbers = Vector{Integer}(undef, length(hash_parts))
    for (idx, part) in enumerate(hash_parts)
        alphabet_salt = [lottery_char; salt_list; alphabet_list][1:len_alphabet]
        alphabet_list = _reorder!(alphabet_list, alphabet_salt)
        number = _unhash(part, alphabet_list)
        isnothing(number) && return Integer[]
        numbers[idx] = something(number)
    end
    encode(config, numbers) == hashid || return Integer[]
    # return numbers
    # promote to uniform types
    return [numbers...]
end

"""
    encodehex(config::Hashids.Configuration, hex::AbstractString)

Convert a hexadecimal string (e.g. a MongoDB id) to a hashid.

# Example
```julia-repl
julia> encodehex(Hashids.configure(), "abcdef123456")
"kmP69lB3xv"

```
"""
function encodehex(config::Configuration, hex::AbstractString)
    isnothing(match(r"^[0-9a-fA-F]+$", hex)) && return ""
    numbers = [parse(Int64, "1" * hex[i:min(i+11,end)], base=16) for i in 1:12:lastindex(hex)]
    encode(config, numbers)
end

"""
    decodehex(config::Hashids.Configuration, hashid::AbstractString)

Resrtore a hexadecimal string (e.g. a MongoDB id) from the passed `hashid`.

# Example
```julia-repl
julia> decodehex(Hashids.configure(), "kmP69lB3xv")
"abcdef123456"

```
"""
function decodehex(config::Configuration, hashid::AbstractString)
    numbers = decode(config, hashid)
    join(string(number, base=16)[2:end] for number in numbers)
end

# Compatibility
@static if !isdefined(Base, :isnothing)
    isnothing(::Nothing) = true
    isnothing(_any) = false
end

# plugins
include("Transcoders.jl")

end # module

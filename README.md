# Hashids.jl

[![Build Status](https://travis-ci.org/antimon2/Hashids.jl.svg?branch=master)](https://travis-ci.org/antimon2/Hashids.jl) [![Cirrus](https://api.cirrus-ci.com/github/antimon2/Hashids.jl.svg)](https://cirrus-ci.com/github/antimon2/Hashids.jl) [![codecov.io](https://codecov.io/github/antimon2/Hashids.jl/coverage.svg?branch=master)](https://codecov.io/github/antimon2/Hashids.jl?branch=master)

A Julia port of the JavaScript Hashids implementation. Website: https://hashids.org/

## Installation

To install, run on the Julia Pkg REPL-mode:

```julia
pkg> add Hashids
```

To install the latest development version, run the following command instead:

```julia
pkg> add Hashids#master
```

Then you can run the built-in unit tests with

```julia
pkg> test Hashids
```

to verify that everything is functioning properly on your machine.


## Usage

Import the `Hashids` module with `using` statement:

```julia
julia> using Hashids
```

### Basic Usage

Configure (with default parameters):

```julia
julia> conf = Hashids.configure();
```

Encode a single integer:

```julia
julia> encode(conf, 123)
"Mj3"
```

Decode a hash (returns 1-element Integer Array):

```julia
julia> decode(conf, "xoz")
1-element Array{Int64,1}:
 456
```

Encode several integers:

```julia
julia> encode(conf, 123, 456, 789)
"El3fkRIo3"

julia> encode(conf, [123, 456, 789])  # same as above
"El3fkRIo3"
```

Decode a hash (returns N-elements Integer Array):

```julia
julia> decode(conf, "1B8UvJfXm")
3-element Array{Int64,1}:
 517
 729
 185
```

### Using Custom Salt

Hashids supports salting hashes by accepting a `salt` value. If you don’t want others to decode your hashes, provide a unique string to `Hashids.configure()`.

```julia
julia> conf = Hashids.configure(salt="this is my salt 1");

julia> encode(conf, 123)
"nVB"
```

The generated hash changes whenever the salt is changed:

```julia
julia> conf = Hashids.configure("this is my salt 2");  # equivalent to `Hashids.configure(salt="this is my salt 2")`

julia> encode(conf, 123)
"ojK"
```

A salt string between 6 and 32 characters provides decent randomization.

### Controlling Hash Length

By default, hashes are going to be the shortest possible. One reason you might want to increase the hash length is to obfuscate how large the integer behind the hash is.

This is done by passing the `min_length` to `Hashids.configure()`. Hashes are padded with extra characters to make them seem longer.

```julia
julia> conf = Hashids.configure(min_length=16);

julia> encode(conf, 1)
"4q2VolejRejNmGQB"
```

### Using A Custom Alphabet

It’s possible to set a custom alphabet for your hashes. The default alphabet is `"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"`.

To have only lowercase letters in your hashes, pass in the following custom alphabet:

```julia
julia> conf = Hashids.configure(alphabet="abcdefghijklmnopqrstuvwxyz");

julia> encode(conf, 123456789)
"kekmyzyk"
```

A custom alphabet must contain at least 16 characters.

You can even use emojis as the alphabet.

### Encode hex instead of numbers

Useful if you want to encode numbers like Mongo's ObjectIds.

```julia
julia> conf = Hashids.configure();

julia> hashid = encodehex(conf, "507f1f77bcf86cd799439011")
"y42LW46J9luq3Xq9XMly"

julia> hex = decodehex(conf, hashid)
"507f1f77bcf86cd799439011"
```

Please note that this is not the equivalent of:

```julia
julia> conf = Hashids.configure();

julia> hashid = encode(conf, big"0x507f1f77bcf86cd799439011")
"y8qpJL3ZgzJ8lWk4GEV"

julia> hex = string(decode(conf, hashid)[1], base=16)
"507f1f77bcf86cd799439011"
```

The difference between the two is that the built-in `encodehex` will always result in the same length, even if it contained leading zeros.

For example `encodehex(conf, "00000000")` would encode to `"qExOgK7"` and decode back to `"00000000"` (length information is preserved).

## Randomness

The primary purpose of hashids is to obfuscate ids. It's not meant or tested to be used for security purposes or compression. Having said that, this algorithm does try to make these hashes unguessable and unpredictable:

### Repeating numbers

There are no repeating patterns that might show that there are 4 identical numbers in the hash:

```julia
julia> conf = Hashids.configure("this is my salt");

julia> encode(conf, 5, 5, 5, 5)
"1Wc8cwcE"
```

The same is valid for incremented numbers:

```julia
julia> encode(conf, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
"kRHnurhptKcjIDTWC3sx"

julia> encode(conf, 1)
"NV"

julia> encode(conf, 2)
"6m"

julia> encode(conf, 3)
"yD"

julia> encode(conf, 4)
"2l"

julia> encode(conf, 5)
"rD"
```

## Curses! \#$%@

This code was written with the intent of placing generated hashes in visible places – like the URL. Which makes it unfortunate if generated hashes accidentally formed a bad word.

Therefore, the algorithm tries to avoid generating most common English curse words by never placing the following letters next to each other: **c, C, s, S, f, F, h, H, u, U, i, I, t, T**.

## Int / Int64 / Int128 / BigInt

Julia supports several bitrange Integers (`Int8` / `UInt8` / `Int16` / `UInt16` / `Int32` / `UInt32` / `Int64` / `UInt64` / `Int128` / `UInt128`) and `BigInt`. You can use the standard API to encode all of them the same way.

When decoding a hashid, the algorithm tries to decode it to the system `Int` type (`Int64` if x64 architecture). In case of overflow, bitrange is automatically expanded (`Int64` → `Int128` → `BigInt`). It does not throw an error.

## License

MIT license, see the [LICENSE](LICENSE) file. You can use hashids in open source projects and commercial products.

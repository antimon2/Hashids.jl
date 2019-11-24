module Transcoders

import Base.transcode
using ..Hashids

export transcode, HashidsEncoder, HashidsDecoder, HashidsHexEncoder, HashidsHexDecoder

abstract type Transcoder end

struct HashidsEncoder <: Transcoder
    config::Hashids.Configuration
end
HashidsEncoder(salt::AbstractString) = HashidsEncoder(Hashids.configure(salt))
HashidsEncoder(; kwargs...) = HashidsEncoder(Hashids.configure(; kwargs...))

transcode(encoder::HashidsEncoder, values...) = encode(encoder.config, values...)

struct HashidsDecoder <: Transcoder
    config::Hashids.Configuration
end
HashidsDecoder(salt::AbstractString) = HashidsDecoder(Hashids.configure(salt))
HashidsDecoder(; kwargs...) = HashidsDecoder(Hashids.configure(; kwargs...))

transcode(decoder::HashidsDecoder, hashid::String) = decode(decoder.config, hashid)

struct HashidsHexEncoder <: Transcoder
    config::Hashids.Configuration
end
HashidsHexEncoder(salt::AbstractString) = HashidsHexEncoder(Hashids.configure(salt))
HashidsHexEncoder(; kwargs...) = HashidsHexEncoder(Hashids.configure(; kwargs...))

transcode(encoder::HashidsHexEncoder, hex::String) = encodehex(encoder.config, hex)

struct HashidsHexDecoder <: Transcoder
    config::Hashids.Configuration
end
HashidsHexDecoder(salt::AbstractString) = HashidsHexDecoder(Hashids.configure(salt))
HashidsHexDecoder(; kwargs...) = HashidsHexDecoder(Hashids.configure(; kwargs...))

transcode(decoder::HashidsHexDecoder, hashid::String) = decodehex(decoder.config, hashid)

# convert Transcoders each other
for T in (HashidsEncoder, HashidsDecoder, HashidsHexEncoder, HashidsHexDecoder)
    @eval (::Type{$T})(transcoder::$T) = transcoder
    @eval (::Type{$T})(transcoder::Transcoder) = $T(transcoder.config)
end
Base.convert(::Type{T}, transcoder::T) where {T <: Transcoder} = transcoder
Base.convert(::Type{T}, transcoder::Transcoder) where {T <: Transcoder} = T(transcoder)

end  # module

module Transcoders

import Base.transcode
using ..Hashids

export transcode, HashidsEncoder, HashidsDecoder, HashidsHexEncoder, HashidsHexDecoder

struct HashidsEncoder
    config::Hashids.Configuration
end
HashidsEncoder(salt::AbstractString) = HashidsEncoder(Hashids.configure(salt))
HashidsEncoder(; kwargs...) = HashidsEncoder(Hashids.configure(; kwargs...))

transcode(encoder::HashidsEncoder, values...) = encode(encoder.config, values...)

struct HashidsDecoder
    config::Hashids.Configuration
end
HashidsDecoder(salt::AbstractString) = HashidsDecoder(Hashids.configure(salt))
HashidsDecoder(; kwargs...) = HashidsDecoder(Hashids.configure(; kwargs...))

transcode(decoder::HashidsDecoder, hashid::String) = decode(decoder.config, hashid)

struct HashidsHexEncoder
    config::Hashids.Configuration
end
HashidsHexEncoder(salt::AbstractString) = HashidsHexEncoder(Hashids.configure(salt))
HashidsHexEncoder(; kwargs...) = HashidsHexEncoder(Hashids.configure(; kwargs...))

transcode(encoder::HashidsHexEncoder, hex::String) = encodehex(encoder.config, hex)

struct HashidsHexDecoder
    config::Hashids.Configuration
end
HashidsHexDecoder(salt::AbstractString) = HashidsHexDecoder(Hashids.configure(salt))
HashidsHexDecoder(; kwargs...) = HashidsHexDecoder(Hashids.configure(; kwargs...))

transcode(decoder::HashidsHexDecoder, hashid::String) = decodehex(decoder.config, hashid)

end  # module

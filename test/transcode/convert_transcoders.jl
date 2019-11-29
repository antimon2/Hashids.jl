module ConvertTranscodersTest

using Hashids.Transcoders
using Hashids: configure
using Test

@testset "Default Configuration" begin

@test HashidsEncoder(HashidsEncoder()) == HashidsEncoder()
@test HashidsEncoder(HashidsDecoder()) == HashidsEncoder()
@test HashidsDecoder(HashidsEncoder()) == HashidsDecoder()
@test HashidsDecoder(HashidsDecoder()) == HashidsDecoder()

end

@testset "Custom Configuration Hex" begin

config = configure(
    salt="this is my salt",
    min_length=30,
    alphabet="xzal86grmb4jhysfoqp3we7291kuct5iv0nd"
)
encoder = HashidsHexEncoder(config)
decoder = HashidsHexDecoder(config)

@test HashidsHexEncoder(encoder) == encoder
@test HashidsHexEncoder(decoder) == encoder
@test HashidsHexDecoder(encoder) == decoder
@test HashidsHexDecoder(decoder) == decoder

end

@testset "`convert` method" begin

config = configure(
    salt="this is my salt",
    min_length=30,
    alphabet="xzal86grmb4jhysfoqp3we7291kuct5iv0nd"
)
encoder = HashidsEncoder(config)
decoder = HashidsDecoder(config)

@test convert(HashidsEncoder, encoder) == encoder
@test convert(HashidsDecoder, encoder) == decoder
@test convert(HashidsEncoder, decoder) == encoder
@test convert(HashidsDecoder, decoder) == decoder

end

end  # module

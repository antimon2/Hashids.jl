module CustomConfigHexTest

using Hashids.Transcoders
using Hashids: configure
using Test

@testset "Custom Config Hex" begin

config = configure(
    salt="this is my salt",
    min_length=30,
    alphabet="xzal86grmb4jhysfoqp3we7291kuct5iv0nd"
)
encoder = HashidsHexEncoder(config)
decoder = HashidsHexDecoder(config)

@testset "encodehex and decodehex back" begin

@test transcode(decoder, transcode(encoder, "deadbeef")) == "deadbeef"
@test transcode(decoder, transcode(encoder, "abcdef123456")) == "abcdef123456"
@test transcode(decoder, transcode(encoder, "ABCDDD6666DDEEEEEEEEE")) == lowercase("ABCDDD6666DDEEEEEEEEE")
@test transcode(decoder, transcode(encoder, "507f1f77bcf86cd799439011")) == "507f1f77bcf86cd799439011"
@test transcode(decoder, transcode(encoder, "f00000fddddddeeeee4444444ababab")) == "f00000fddddddeeeee4444444ababab"
@test transcode(decoder, transcode(encoder, "abcdef123456abcdef123456abcdef123456")) == "abcdef123456abcdef123456abcdef123456"
@test transcode(decoder, transcode(encoder, "f000000000000000000000000000000000000000000000000000f")) == "f000000000000000000000000000000000000000000000000000f"
@test transcode(decoder, transcode(encoder, "fffffffffffffffffffffffffffffffffffffffffffffffffffff")) == "fffffffffffffffffffffffffffffffffffffffffffffffffffff"

end  # of "encodehex and decodehex back"

@testset "encodehex" begin

@test transcode(encoder, "deadbeef") == "0dbq3jwa8p4b3gk6gb8bv21goerm96"
@test transcode(encoder, "abcdef123456") == "190obdnk4j02pajjdande7aqj628mr"
@test transcode(encoder, "ABCDDD6666DDEEEEEEEEE") == "a1nvl5d9m3yo8pj1fqag8p9pqw4dyl"
@test transcode(encoder, "507f1f77bcf86cd799439011") == "1nvlml93k3066oas3l9lr1wn1k67dy"
@test transcode(encoder, "f00000fddddddeeeee4444444ababab") == "mgyband33ye3c6jj16yq1jayh6krqjbo"
@test transcode(encoder, "abcdef123456abcdef123456abcdef123456") == "9mnwgllqg1q2tdo63yya35a9ukgl6bbn6qn8"
@test transcode(encoder, "f000000000000000000000000000000000000000000000000000f") == "edjrkn9m6o69s0ewnq5lqanqsmk6loayorlohwd963r53e63xmml29"
@test transcode(encoder, "fffffffffffffffffffffffffffffffffffffffffffffffffffff") == "grekpy53r2pjxwyjkl9aw0k3t5la1b8d5r1ex9bgeqmy93eata0eq0"

end  # of "encodehex"

end  # of "Custom Config Hex"

@testset "Custom Salt Hex" begin

@testset "encodehex and decodehex back" begin

encoder = HashidsHexEncoder("this is my salt")
decoder = HashidsHexDecoder("this is my salt")

@test transcode(decoder, transcode(encoder, "deadbeef")) == "deadbeef"
@test transcode(decoder, transcode(encoder, "abcdef123456")) == "abcdef123456"
@test transcode(decoder, transcode(encoder, "ABCDDD6666DDEEEEEEEEE")) == lowercase("ABCDDD6666DDEEEEEEEEE")
@test transcode(decoder, transcode(encoder, "507f1f77bcf86cd799439011")) == "507f1f77bcf86cd799439011"
@test transcode(decoder, transcode(encoder, "f00000fddddddeeeee4444444ababab")) == "f00000fddddddeeeee4444444ababab"
@test transcode(decoder, transcode(encoder, "abcdef123456abcdef123456abcdef123456")) == "abcdef123456abcdef123456abcdef123456"
@test transcode(decoder, transcode(encoder, "f000000000000000000000000000000000000000000000000000f")) == "f000000000000000000000000000000000000000000000000000f"
@test transcode(decoder, transcode(encoder, "fffffffffffffffffffffffffffffffffffffffffffffffffffff")) == "fffffffffffffffffffffffffffffffffffffffffffffffffffff"

end  # of "encodehex and decodehex back"

end  # of "Custom Salt Hex"

end  # module

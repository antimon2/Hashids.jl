module DefaultConfigTranscodeHexTest

using Hashids.Transcoders
using Test

@testset "Default Config Hex" begin

encoder = HashidsHexEncoder()
decoder = HashidsHexDecoder()

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

@test transcode(encoder, "deadbeef") == "wpVL4j9g"
@test transcode(encoder, "abcdef123456") == "kmP69lB3xv"
@test transcode(encoder, "ABCDDD6666DDEEEEEEEEE") == "47JWg0kv4VU0G2KBO2"
@test transcode(encoder, "507f1f77bcf86cd799439011") == "y42LW46J9luq3Xq9XMly"
@test transcode(encoder, "f00000fddddddeeeee4444444ababab") == "m1rO8xBQNquXmLvmO65BUO9KQmj"
@test transcode(encoder, "abcdef123456abcdef123456abcdef123456") == "wBlnMA23NLIQDgw7XxErc2mlNyAjpw"
@test transcode(encoder, "f000000000000000000000000000000000000000000000000000f") == "VwLAoD9BqlT7xn4ZnBXJFmGZ51ZqrBhqrymEyvYLIP199"
@test transcode(encoder, "fffffffffffffffffffffffffffffffffffffffffffffffffffff") == "nBrz1rYyV0C0XKNXxB54fWN0yNvVjlip7127Jo3ri0Pqw"

end  # of "encodehex"

end  # of "Default Config Hex"

end  # module

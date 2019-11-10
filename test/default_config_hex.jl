module DefaultConfigHexTest

using Hashids
using Test

@testset "Default Config Hex" begin

config = Hashids.configure()

@testset "encodehex and decodehex back" begin

@test Hashids.decodehex(config, Hashids.encodehex(config, "deadbeef")) == "deadbeef"
@test Hashids.decodehex(config, Hashids.encodehex(config, "abcdef123456")) == "abcdef123456"
@test Hashids.decodehex(config, Hashids.encodehex(config, "ABCDDD6666DDEEEEEEEEE")) == lowercase("ABCDDD6666DDEEEEEEEEE")
@test Hashids.decodehex(config, Hashids.encodehex(config, "507f1f77bcf86cd799439011")) == "507f1f77bcf86cd799439011"
@test Hashids.decodehex(config, Hashids.encodehex(config, "f00000fddddddeeeee4444444ababab")) == "f00000fddddddeeeee4444444ababab"
@test Hashids.decodehex(config, Hashids.encodehex(config, "abcdef123456abcdef123456abcdef123456")) == "abcdef123456abcdef123456abcdef123456"
@test Hashids.decodehex(config, Hashids.encodehex(config, "f000000000000000000000000000000000000000000000000000f")) == "f000000000000000000000000000000000000000000000000000f"
@test Hashids.decodehex(config, Hashids.encodehex(config, "fffffffffffffffffffffffffffffffffffffffffffffffffffff")) == "fffffffffffffffffffffffffffffffffffffffffffffffffffff"

end  # of "encodehex and decodehex back"

@testset "encodehex" begin

@test Hashids.encodehex(config, "deadbeef") == "wpVL4j9g"
@test Hashids.encodehex(config, "abcdef123456") == "kmP69lB3xv"
@test Hashids.encodehex(config, "ABCDDD6666DDEEEEEEEEE") == "47JWg0kv4VU0G2KBO2"
@test Hashids.encodehex(config, "507f1f77bcf86cd799439011") == "y42LW46J9luq3Xq9XMly"
@test Hashids.encodehex(config, "f00000fddddddeeeee4444444ababab") == "m1rO8xBQNquXmLvmO65BUO9KQmj"
@test Hashids.encodehex(config, "abcdef123456abcdef123456abcdef123456") == "wBlnMA23NLIQDgw7XxErc2mlNyAjpw"
@test Hashids.encodehex(config, "f000000000000000000000000000000000000000000000000000f") == "VwLAoD9BqlT7xn4ZnBXJFmGZ51ZqrBhqrymEyvYLIP199"
@test Hashids.encodehex(config, "fffffffffffffffffffffffffffffffffffffffffffffffffffff") == "nBrz1rYyV0C0XKNXxB54fWN0yNvVjlip7127Jo3ri0Pqw"

end  # of "encodehex"

end  # of "Default Config Hex"

end  # module

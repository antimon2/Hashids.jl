module DefaultConfigHexTest

using Hashids
using Test

@testset "Default Config Hex" begin

config = Hashids.configure()

@testset "encodehex and decodehex back" begin

@test decodehex(config, encodehex(config, "deadbeef")) == "deadbeef"
@test decodehex(config, encodehex(config, "abcdef123456")) == "abcdef123456"
@test decodehex(config, encodehex(config, "ABCDDD6666DDEEEEEEEEE")) == lowercase("ABCDDD6666DDEEEEEEEEE")
@test decodehex(config, encodehex(config, "507f1f77bcf86cd799439011")) == "507f1f77bcf86cd799439011"
@test decodehex(config, encodehex(config, "f00000fddddddeeeee4444444ababab")) == "f00000fddddddeeeee4444444ababab"
@test decodehex(config, encodehex(config, "abcdef123456abcdef123456abcdef123456")) == "abcdef123456abcdef123456abcdef123456"
@test decodehex(config, encodehex(config, "f000000000000000000000000000000000000000000000000000f")) == "f000000000000000000000000000000000000000000000000000f"
@test decodehex(config, encodehex(config, "fffffffffffffffffffffffffffffffffffffffffffffffffffff")) == "fffffffffffffffffffffffffffffffffffffffffffffffffffff"

end  # of "encodehex and decodehex back"

@testset "encodehex" begin

@test encodehex(config, "deadbeef") == "wpVL4j9g"
@test encodehex(config, "abcdef123456") == "kmP69lB3xv"
@test encodehex(config, "ABCDDD6666DDEEEEEEEEE") == "47JWg0kv4VU0G2KBO2"
@test encodehex(config, "507f1f77bcf86cd799439011") == "y42LW46J9luq3Xq9XMly"
@test encodehex(config, "f00000fddddddeeeee4444444ababab") == "m1rO8xBQNquXmLvmO65BUO9KQmj"
@test encodehex(config, "abcdef123456abcdef123456abcdef123456") == "wBlnMA23NLIQDgw7XxErc2mlNyAjpw"
@test encodehex(config, "f000000000000000000000000000000000000000000000000000f") == "VwLAoD9BqlT7xn4ZnBXJFmGZ51ZqrBhqrymEyvYLIP199"
@test encodehex(config, "fffffffffffffffffffffffffffffffffffffffffffffffffffff") == "nBrz1rYyV0C0XKNXxB54fWN0yNvVjlip7127Jo3ri0Pqw"

end  # of "encodehex"

end  # of "Default Config Hex"

end  # module

module CustomConfigHexTest

using Hashids
using Test

@testset "Custom Config Hex" begin

config = Hashids.configure(
    salt="this is my salt",
    min_length=30,
    alphabet="xzal86grmb4jhysfoqp3we7291kuct5iv0nd"
)

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

@test encodehex(config, "deadbeef") == "0dbq3jwa8p4b3gk6gb8bv21goerm96"
@test encodehex(config, "abcdef123456") == "190obdnk4j02pajjdande7aqj628mr"
@test encodehex(config, "ABCDDD6666DDEEEEEEEEE") == "a1nvl5d9m3yo8pj1fqag8p9pqw4dyl"
@test encodehex(config, "507f1f77bcf86cd799439011") == "1nvlml93k3066oas3l9lr1wn1k67dy"
@test encodehex(config, "f00000fddddddeeeee4444444ababab") == "mgyband33ye3c6jj16yq1jayh6krqjbo"
@test encodehex(config, "abcdef123456abcdef123456abcdef123456") == "9mnwgllqg1q2tdo63yya35a9ukgl6bbn6qn8"
@test encodehex(config, "f000000000000000000000000000000000000000000000000000f") == "edjrkn9m6o69s0ewnq5lqanqsmk6loayorlohwd963r53e63xmml29"
@test encodehex(config, "fffffffffffffffffffffffffffffffffffffffffffffffffffff") == "grekpy53r2pjxwyjkl9aw0k3t5la1b8d5r1ex9bgeqmy93eata0eq0"

end  # of "encodehex"

end  # of "Custom Config Hex"

end  # module

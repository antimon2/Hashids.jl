module DefaultConfigTest

using Hashids
using Test

@testset "Default Config" begin

config = Hashids.configure()

@testset "encode numbers" begin

@test encode(config, 0) == "gY"
@test encode(config, 1) == "jR"
@test encode(config, 347) == "l7J"
@test encode(config, 928728) == "R8ZN0"
@test encode(config, 1, 2, 3) == "o2fXhV"
@test encode(config, 1, 0, 0) == "jRfMcP"
@test encode(config, 0, 0, 1) == "jQcMcW"
@test encode(config, 0, 0, 0) == "gYcxcr"
@test encode(config, 1000000000000) == "gLpmopgO6"
@test encode(config, 9007199254740991) == "lEW77X7g527"
@test encode(config, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test encode(config, 10000000000, 0, 0, 0, 999999999999999) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test encode(config, 9007199254740991, 9007199254740991, 9007199254740991) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test encode(config, 1000000001, 1000000002, 1000000003, 1000000004, 1000000005) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test encode(config, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test encode(config, 827364827638428762424, 0x410498019283098083) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test encode(config, 340282366920938463463374607431768211456) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numbers"

@testset "encode numberlist" begin

@test encode(config, [0]) == "gY"
@test encode(config, [1]) == "jR"
@test encode(config, [347]) == "l7J"
@test encode(config, [928728]) == "R8ZN0"
@test encode(config, [1, 2, 3]) == "o2fXhV"
@test encode(config, [1, 0, 0]) == "jRfMcP"
@test encode(config, [0, 0, 1]) == "jQcMcW"
@test encode(config, [0, 0, 0]) == "gYcxcr"
@test encode(config, [1000000000000]) == "gLpmopgO6"
@test encode(config, [9007199254740991]) == "lEW77X7g527"
@test encode(config, [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test encode(config, [10000000000, 0, 0, 0, 999999999999999]) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test encode(config, [9007199254740991, 9007199254740991, 9007199254740991]) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test encode(config, [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test encode(config, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test encode(config, [827364827638428762424, 0x410498019283098083]) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test encode(config, [340282366920938463463374607431768211456]) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numberlist"

@testset "decode" begin

@test decode(config, "gY") == [0]
@test decode(config, "jR") == [1]
@test decode(config, "l7J") == [347]
@test decode(config, "R8ZN0") == [928728]
@test decode(config, "o2fXhV") == [1, 2, 3]
@test decode(config, "jRfMcP") == [1, 0, 0]
@test decode(config, "jQcMcW") == [0, 0, 1]
@test decode(config, "gYcxcr") == [0, 0, 0]
@test decode(config, "gLpmopgO6") == [1000000000000]
@test decode(config, "lEW77X7g527") == [9007199254740991]
@test decode(config, "BrtltWt2tyt1tvt7tJt2t1tD") == [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
@test decode(config, "G6XOnGQgIpcVcXcqZ4B8Q8B9y") == [10000000000, 0, 0, 0, 999999999999999]
@test decode(config, "5KoLLVL49RLhYkppOplM6piwWNNANny8N") == [9007199254740991, 9007199254740991, 9007199254740991]
@test decode(config, "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx") == [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]
@test decode(config, "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN") == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
@test decode(config, "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX") == [827364827638428762424, 0x410498019283098083]
@test decode(config, "x6yAV3RXwvrB4x7x4jovKBYyJ") == [340282366920938463463374607431768211456]

end  # of "decode"

end  # of "Default Config"

end  # module

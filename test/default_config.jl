module DefaultConfigTest

using Hashids
using Test

@testset "Default Config" begin

config = Hashids.configure()

@testset "encode numbers" begin

@test Hashids.encode(config, 0) == "gY"
@test Hashids.encode(config, 1) == "jR"
@test Hashids.encode(config, 347) == "l7J"
@test Hashids.encode(config, 928728) == "R8ZN0"
@test Hashids.encode(config, 1, 2, 3) == "o2fXhV"
@test Hashids.encode(config, 1, 0, 0) == "jRfMcP"
@test Hashids.encode(config, 0, 0, 1) == "jQcMcW"
@test Hashids.encode(config, 0, 0, 0) == "gYcxcr"
@test Hashids.encode(config, 1000000000000) == "gLpmopgO6"
@test Hashids.encode(config, 9007199254740991) == "lEW77X7g527"
@test Hashids.encode(config, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test Hashids.encode(config, 10000000000, 0, 0, 0, 999999999999999) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test Hashids.encode(config, 9007199254740991, 9007199254740991, 9007199254740991) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test Hashids.encode(config, 1000000001, 1000000002, 1000000003, 1000000004, 1000000005) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test Hashids.encode(config, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test Hashids.encode(config, 827364827638428762424, 0x410498019283098083) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test Hashids.encode(config, 340282366920938463463374607431768211456) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numbers"

@testset "encode numberlist" begin

@test Hashids.encode(config, [0]) == "gY"
@test Hashids.encode(config, [1]) == "jR"
@test Hashids.encode(config, [347]) == "l7J"
@test Hashids.encode(config, [928728]) == "R8ZN0"
@test Hashids.encode(config, [1, 2, 3]) == "o2fXhV"
@test Hashids.encode(config, [1, 0, 0]) == "jRfMcP"
@test Hashids.encode(config, [0, 0, 1]) == "jQcMcW"
@test Hashids.encode(config, [0, 0, 0]) == "gYcxcr"
@test Hashids.encode(config, [1000000000000]) == "gLpmopgO6"
@test Hashids.encode(config, [9007199254740991]) == "lEW77X7g527"
@test Hashids.encode(config, [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test Hashids.encode(config, [10000000000, 0, 0, 0, 999999999999999]) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test Hashids.encode(config, [9007199254740991, 9007199254740991, 9007199254740991]) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test Hashids.encode(config, [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test Hashids.encode(config, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test Hashids.encode(config, [827364827638428762424, 0x410498019283098083]) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test Hashids.encode(config, [340282366920938463463374607431768211456]) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numberlist"

@testset "decode" begin

@test Hashids.decode(config, "gY") == [0]
@test Hashids.decode(config, "jR") == [1]
@test Hashids.decode(config, "l7J") == [347]
@test Hashids.decode(config, "R8ZN0") == [928728]
@test Hashids.decode(config, "o2fXhV") == [1, 2, 3]
@test Hashids.decode(config, "jRfMcP") == [1, 0, 0]
@test Hashids.decode(config, "jQcMcW") == [0, 0, 1]
@test Hashids.decode(config, "gYcxcr") == [0, 0, 0]
@test Hashids.decode(config, "gLpmopgO6") == [1000000000000]
@test Hashids.decode(config, "lEW77X7g527") == [9007199254740991]
@test Hashids.decode(config, "BrtltWt2tyt1tvt7tJt2t1tD") == [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
@test Hashids.decode(config, "G6XOnGQgIpcVcXcqZ4B8Q8B9y") == [10000000000, 0, 0, 0, 999999999999999]
@test Hashids.decode(config, "5KoLLVL49RLhYkppOplM6piwWNNANny8N") == [9007199254740991, 9007199254740991, 9007199254740991]
@test Hashids.decode(config, "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx") == [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]
@test Hashids.decode(config, "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN") == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
@test Hashids.decode(config, "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX") == [827364827638428762424, 0x410498019283098083]
@test Hashids.decode(config, "x6yAV3RXwvrB4x7x4jovKBYyJ") == [340282366920938463463374607431768211456]

end  # of "decode"

end  # of "Default Config"

end  # module

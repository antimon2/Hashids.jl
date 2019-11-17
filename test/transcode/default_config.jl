module DefaultConfigTranscodeTest

using Hashids.Transcoders
using Test

@testset "Default Config" begin

encoder = HashidsEncoder()
decoder = HashidsDecoder()

@testset "encode numbers" begin

@test transcode(encoder, 0) == "gY"
@test transcode(encoder, 1) == "jR"
@test transcode(encoder, 347) == "l7J"
@test transcode(encoder, 928728) == "R8ZN0"
@test transcode(encoder, 1, 2, 3) == "o2fXhV"
@test transcode(encoder, 1, 0, 0) == "jRfMcP"
@test transcode(encoder, 0, 0, 1) == "jQcMcW"
@test transcode(encoder, 0, 0, 0) == "gYcxcr"
@test transcode(encoder, 1000000000000) == "gLpmopgO6"
@test transcode(encoder, 9007199254740991) == "lEW77X7g527"
@test transcode(encoder, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test transcode(encoder, 10000000000, 0, 0, 0, 999999999999999) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test transcode(encoder, 9007199254740991, 9007199254740991, 9007199254740991) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test transcode(encoder, 1000000001, 1000000002, 1000000003, 1000000004, 1000000005) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test transcode(encoder, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test transcode(encoder, 827364827638428762424, 0x410498019283098083) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test transcode(encoder, 340282366920938463463374607431768211456) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numbers"

@testset "encode numberlist" begin

@test transcode(encoder, [0]) == "gY"
@test transcode(encoder, [1]) == "jR"
@test transcode(encoder, [347]) == "l7J"
@test transcode(encoder, [928728]) == "R8ZN0"
@test transcode(encoder, [1, 2, 3]) == "o2fXhV"
@test transcode(encoder, [1, 0, 0]) == "jRfMcP"
@test transcode(encoder, [0, 0, 1]) == "jQcMcW"
@test transcode(encoder, [0, 0, 0]) == "gYcxcr"
@test transcode(encoder, [1000000000000]) == "gLpmopgO6"
@test transcode(encoder, [9007199254740991]) == "lEW77X7g527"
@test transcode(encoder, [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]) == "BrtltWt2tyt1tvt7tJt2t1tD"
@test transcode(encoder, [10000000000, 0, 0, 0, 999999999999999]) == "G6XOnGQgIpcVcXcqZ4B8Q8B9y"
@test transcode(encoder, [9007199254740991, 9007199254740991, 9007199254740991]) == "5KoLLVL49RLhYkppOplM6piwWNNANny8N"
@test transcode(encoder, [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]) == "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx"
@test transcode(encoder, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) == "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN"
@test transcode(encoder, [827364827638428762424, 0x410498019283098083]) == "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX"
@test transcode(encoder, [340282366920938463463374607431768211456]) == "x6yAV3RXwvrB4x7x4jovKBYyJ"

end  # of "encode numberlist"

@testset "decode" begin

@test transcode(decoder, "gY") == [0]
@test transcode(decoder, "jR") == [1]
@test transcode(decoder, "l7J") == [347]
@test transcode(decoder, "R8ZN0") == [928728]
@test transcode(decoder, "o2fXhV") == [1, 2, 3]
@test transcode(decoder, "jRfMcP") == [1, 0, 0]
@test transcode(decoder, "jQcMcW") == [0, 0, 1]
@test transcode(decoder, "gYcxcr") == [0, 0, 0]
@test transcode(decoder, "gLpmopgO6") == [1000000000000]
@test transcode(decoder, "lEW77X7g527") == [9007199254740991]
@test transcode(decoder, "BrtltWt2tyt1tvt7tJt2t1tD") == [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
@test transcode(decoder, "G6XOnGQgIpcVcXcqZ4B8Q8B9y") == [10000000000, 0, 0, 0, 999999999999999]
@test transcode(decoder, "5KoLLVL49RLhYkppOplM6piwWNNANny8N") == [9007199254740991, 9007199254740991, 9007199254740991]
@test transcode(decoder, "BPg3Qx5f8VrvQkS16wpmwIgj9Q4Jsr93gqx") == [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]
@test transcode(decoder, "1wfphpilsMtNumCRFRHXIDSqT2UPcWf1hZi3s7tN") == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
@test transcode(decoder, "jJ1gD0Kg2OLKGgIVwZm4Wow6EgLX") == [827364827638428762424, 0x410498019283098083]
@test transcode(decoder, "x6yAV3RXwvrB4x7x4jovKBYyJ") == [340282366920938463463374607431768211456]

end  # of "decode"

end  # of "Default Config"

end  # module

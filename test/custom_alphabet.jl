module CustomAlphabetTest

using Hashids
using Test

const TESTDATA = [
    [0],
    [1, 2, 3],
    [10000000000, 0, 0, 0, 999999999999999],
    [827364827638428762424, 0x410498019283098083],
    [340282366920938463463374607431768211456]
]

function test_with_custom_alphabet(alphabet::String)
    config = Hashids.configure(alphabet=alphabet)
    for numbers in TESTDATA
        @test Hashids.decode(config, Hashids.encode(config, numbers)) == numbers
    end
end

@testset "Custom Alphabet" begin

@testset "Worst Alphabet" begin
    test_with_custom_alphabet("cCsSfFhHuUiItT01")
end  # of "Worst Alphabet"

@testset "Containing Spaces" begin
    test_with_custom_alphabet("cCsSfFhH uUiItT01")
end  # of "Containing Spaces"

@testset "a Half be Separators" begin
    test_with_custom_alphabet("abdegjklCFHISTUc")
end  # of "a Half be Separators"

@testset "2 Separators" begin
    test_with_custom_alphabet("abdegjklmnopqrSF")
end  # of "2 Separators"

@testset "No Separators" begin
    test_with_custom_alphabet("abdegjklmnopqrvwxyzABDEGJKLMNOPQRVWXYZ1234567890")
end  # of "No Separators"

@testset "Long Alphabet" begin
    test_with_custom_alphabet(raw"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-_=+\\|'\";:/?.>,<{[}]")
end  # of "Long Alphabet"

@testset "Weird Alphabet" begin
    test_with_custom_alphabet(raw"`~!@#$%^&*()-_=+\\|'\";:/?.>,<{[}]")
end  # of "Weird Alphabet"

@testset "Unicode Chars" begin
    test_with_custom_alphabet("😀😁😂🤣😃😄😅😆😉😊😋😎😍😘🥰😗😙😚")
end  # of "Unicode Chars"

@testset "Complex Unicode Chars" begin
    test_with_custom_alphabet("🤺👩🏿‍🦳🛁👩🏻🦷🤦‍♂️🐁☝🏼✍🏾👉🏽🇸🇰❤️🍭")
end  # of "Complex Unicode Chars"

end  # of "Custom Alphabet"

end  # module

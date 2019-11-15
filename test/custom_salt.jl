module CustomSaltTest

using Hashids
using Test

const TESTDATA = [
    [0],
    [1, 2, 3],
    [10000000000, 0, 0, 0, 999999999999999],
    [827364827638428762424, 0x410498019283098083],
    [340282366920938463463374607431768211456]
]

function test_with_custom_salt(salt::String)
    config = Hashids.configure(salt)
    for numbers in TESTDATA
        @test decode(config, encode(config, numbers)) == numbers
    end
end

@testset "Custom Salt" begin

@testset "\"\"" begin
    test_with_custom_salt("")
end  # of "\"\""

@testset "\"   \"" begin
    test_with_custom_salt("   ")
end  # of "\"   \""

@testset "long salt" begin
    test_with_custom_salt(raw"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-_=+\\|'\";:/?.>,<{[}]")
end  # of "long salt"

@testset "weird salt" begin
    test_with_custom_salt(raw"`~!@#$%^&*()-_=+\\|'\";:/?.>,<{[}]")
end  # of "weird salt"

@testset "ultra weird salt" begin
    test_with_custom_salt("🤺👩🏿‍🦳🛁👩🏻🦷🤦‍♂️🐁☝🏼✍🏾👉🏽🇸🇰❤️🍭")
end  # of "ultra weird salt"

end  # of "Custom Salt"

end  # module

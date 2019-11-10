module MinLengthTest

using Hashids
using Test

const TESTDATA = [
    [0],
    [1, 2, 3],
    [10000000000, 0, 0, 0, 999999999999999],
    [827364827638428762424, 0x410498019283098083],
    [340282366920938463463374607431768211456]
]

function test_with_min_length(min_length::Int)
    config = Hashids.configure(min_length=min_length)
    for numbers in TESTDATA
        hashid = Hashids.encode(config, numbers)
        @test length(hashid) ≥ min_length
        @test Hashids.decode(config, hashid) == numbers
    end
end

@testset "Min Length" begin

@testset "0" begin
    test_with_min_length(0)
end  # of "0"

@testset "1" begin
    test_with_min_length(1)
end  # of "1"

@testset "10" begin
    test_with_min_length(10)
end  # of "10"

@testset "999" begin
    test_with_min_length(999)
end  # of "999"

@testset "1000" begin
    test_with_min_length(1000)
end  # of "1000"

end  # of "Min Length"

end  # module

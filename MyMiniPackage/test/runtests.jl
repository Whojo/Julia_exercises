module MyMiniPackageTest

using MyMiniPackage
using Test

function test_my_convolution(my_convolution)
    @testset "Dimension" begin
        image = rand(Int8, (32, 32))
        kernel = rand(Int8, (3, 3))

        got = my_convolution(image, kernel)
        @test size(got) == size(image)
    end

    @testset "Identity Kernel" begin
        image = rand(Int8, (32, 32))
        kernel = zeros(Int8, 3, 3)
        kernel[2, 2] = 1

        got = my_convolution(image, kernel)
        @test got == image
    end

    @testset "Simple Kernel" begin
        image = [
            4 6 3 1
            5 2 3 1
            3 0 2 1
            1 5 2 3
        ]
        kernel = [
            -1 0 1
            -2 0 2
            -1 0 1
        ]

        expect = [
            14 -4 -11  -9
            10 -6  -6 -11
             7 -3  -1  -9
            10  1  -3  -6
        ]
        got = my_convolution(image, kernel)

        @test got == expect
    end
end

@testset "MyMiniPackage" begin
    @testset "Sequential" begin
        test_my_convolution(my_sequential_convolution)
    end
    @testset "Sequential col-major" begin
        test_my_convolution(my_sequential_convolution_col_major)
    end
    @testset "Multithread" begin
        test_my_convolution(my_naive_multithread_convolution)
    end
end

end # module
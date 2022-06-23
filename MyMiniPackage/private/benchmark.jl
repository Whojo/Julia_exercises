using MyMiniPackage
using BenchmarkTools
using Profile

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

@btime my_sequential_convolution(image, kernel)
@btime my_naive_multithread_convolution(image, kernel) # Way slower (x12.5 with 8 threads)

# Let's try the default profiler
Profile.init(delay=1.0e-7)
@profile (for i in 1:10_000 my_naive_multithread_convolution(image, kernel) end)
Profile.print() # Extremly hard to read ?

# Let's try ProfileView instead
@profview my_naive_multithread_convolution(image, kernel)
@profview my_naive_multithread_convolution(image, kernel)
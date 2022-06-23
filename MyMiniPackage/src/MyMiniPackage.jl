module MyMiniPackage

export my_sequential_convolution,
    my_sequential_convolution_col_major,
    my_naive_multithread_convolution


function get_relative_indexing(mid_ker, x, y, x_ker, y_ker)
    dx, dy = x_ker - 1 - mid_ker, y_ker - 1 - mid_ker
    (x + dx, y + dy)
end

function my_sequential_convolution(image::Matrix, kernel::Matrix)
    x_img_dim, y_img_dim = size(image)
    x_ker_dim, y_ker_dim = size(kernel)

    @assert x_ker_dim == y_ker_dim
    @assert x_ker_dim % 2 == 1
    mid_ker = x_ker_dim ÷ 2

    res = zeros(eltype(image), size(image))
    for x = 1:x_img_dim, y = 1:y_img_dim, x_ker = 1:x_ker_dim, y_ker = 1:y_ker_dim
        new_x, new_y = get_relative_indexing(mid_ker, x, y, x_ker, y_ker)
        if (new_x < 1 || new_y < 1 || new_x > x_img_dim || new_y > y_img_dim)
            continue
        end
        res[x, y] += image[new_x, new_y] * kernel[x_ker, y_ker]
    end

    res
end

function my_sequential_convolution_col_major(image::Matrix, kernel::Matrix)
    x_img_dim, y_img_dim = size(image)
    x_ker_dim, y_ker_dim = size(kernel)

    @assert x_ker_dim == y_ker_dim
    @assert x_ker_dim % 2 == 1
    mid_ker = x_ker_dim ÷ 2

    res = zeros(eltype(image), size(image))
    for y = 1:y_img_dim, x = 1:x_img_dim, x_ker = 1:x_ker_dim, y_ker = 1:y_ker_dim
        new_x, new_y = get_relative_indexing(mid_ker, x, y, x_ker, y_ker)
        if (new_x < 1 || new_y < 1 || new_x > x_img_dim || new_y > y_img_dim)
            continue
        end
        res[x, y] += image[new_x, new_y] * kernel[x_ker, y_ker]
    end

    res
end


function my_naive_multithread_convolution(image::Matrix, kernel::Matrix)
    x_img_dim, y_img_dim = size(image)
    x_ker_dim, y_ker_dim = size(kernel)

    @assert x_ker_dim == y_ker_dim
    @assert x_ker_dim % 2 == 1
    mid_ker = x_ker_dim ÷ 2

    res = zeros(eltype(image), size(image))
    Threads.@threads for x in 1:x_img_dim
        for y in 1:y_img_dim
            for x_ker in 1:x_ker_dim
                for y_ker in 1:y_ker_dim
                    new_x, new_y = get_relative_indexing(mid_ker, x, y, x_ker, y_ker)
                    if (new_x < 1 || new_y < 1 || new_x > x_img_dim || new_y > y_img_dim)
                        continue
                    end
                    res[x, y] += image[new_x, new_y] * kernel[x_ker, y_ker]
                end
            end
        end
    end

    res
end


end # module

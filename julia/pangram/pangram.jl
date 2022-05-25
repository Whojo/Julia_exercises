"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    letters = Dict(c => 0 for c in 'a':'z')

    for char in lowercase(input)
        char ∈ keys(letters) || continue
        letters[char] += 1
    end

    return all(values(letters) .> 0)
end


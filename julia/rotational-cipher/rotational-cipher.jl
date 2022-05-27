"""
    rotate(key, clear_text)

return the encoded `text` through the rotation cipher
"""
# Improvements
# - Precompute a translation dictionnary for larger strings
NB_LETTERS = 26

function overflow(key, char)
    UPPER_ALPHABET = 'A':'Z'

    first = char ∈ UPPER_ALPHABET ? 'A' : 'a'
    return (char - first + key) ≥ NB_LETTERS
end

function rotate_char(key, char)
    new_char = char + key
    return overflow(key, char) ? new_char - NB_LETTERS : new_char
end

function rotate_str(key, clear_text)
    ALPHABET = union('a':'z', 'A':'Z')

    return string(map(clear_text) do char
        char ∈ ALPHABET || return char

        return rotate_char(key, char)
    end)
end

function rotate(key, clear_text)
    if (typeof(clear_text) == String)
        return rotate_str(key, clear_text)
    end

    return rotate_char(key, clear_text)
end

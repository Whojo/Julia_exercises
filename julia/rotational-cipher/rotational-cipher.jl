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

function rotate(key, clear_char::Char)
    ALPHABET = union('a':'z', 'A':'Z')
    clear_char ∈ ALPHABET || return clear_char

    new_char = clear_char + key
    return overflow(key, clear_char) ? new_char - NB_LETTERS : new_char
end

function rotate(key, clear_text::String)
    map(clear_text) do char
        rotate(key, char)
    end
end

macro R13_str(s)
    rotate(13, s)
end

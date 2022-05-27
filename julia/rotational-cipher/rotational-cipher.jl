"""
    rotate(key, clear_text)

return the encoded `text` through the rotation cipher
"""
# Improvements
# - Precompute a translation dictionnary for larger strings
NB_LETTERS = 26

function rotate(key, clear_char::Char)
    isletter(clear_char) || return clear_char

    first = isuppercase(clear_char) ? 'A' : 'a'
    (clear_char - first + key) % NB_LETTERS + first
end

function rotate(key, clear_text::String)
    map(clear_text) do char
        rotate(key, char)
    end
end

macro R13_str(s)
    rotate(13, s)
end

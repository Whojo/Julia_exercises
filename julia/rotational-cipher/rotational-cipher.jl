"""
    rotate(key, clear_text)

return the encoded `text` through the rotation cipher
"""
# Improvements
# - Precompute a translation dictionnary for larger strings

function translate(char, key, first)
   (char - first + key) % 26 + first
end

function rotate_long(key, clear_text::String)
    translate = Dict(c => translate(c, key, first(range))
                     for range in ('a':'z', 'A':'Z')
                     for c in range)

    map(clear_text) do char
        haskey(translate, char) ? translate[char] : char
    end
end

function rotate(key, clear_char::Char)
    NB_LETTERS = 26
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

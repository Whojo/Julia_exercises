"""
    raindrops(number)

Return a raindrop song according to certain rule
"""
function raindrops(number)
    song = ""
    if (number % 3 == 0)
        song *= "Pling"
    end
    if (number % 5 == 0)
        song *= "Plang"
    end
    if (number % 7 == 0)
        song *= "Plong"
    end

    isempty(song) ? string(number) : song
end

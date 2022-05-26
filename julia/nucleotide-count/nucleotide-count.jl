"""
    count_nucleotides(strand)

The count of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    bases = ('A', 'C', 'G', 'T')
    nucleotides_counter = Dict(bases .=> 0)
    for nucleotide in strand
        if (nucleotide ∉ keys(nucleotides_counter))
            throw(DomainError(nucleotide, "Passed letter is not a nucleotide $bases"))
        end

        nucleotides_counter[nucleotide] += 1
    end

    return nucleotides_counter
end

"""
    count_nucleotides(strand)

The count of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    nucleotides_counter = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for nucleotide in strand
        if (!haskey(nucleotides_counter, nucleotide))
            throw(DomainError(nucleotide, "Passed letter is not a nucleotide"))
        end

        nucleotides_counter[nucleotide] += 1
    end

    return nucleotides_counter
end

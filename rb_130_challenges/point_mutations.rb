##### RB 130 Challenges Point Mutations #####
=begin

#PEDAC

We will be given two strands of DNA.
We need to count the differences between them.
If one strand is shorter than the other, we only need to check for differences for the length of the shorter strand.

=end

class DNA
  attr_reader :strand

  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comp_strand)
    comps = [strand, comp_strand].sort_by { |x| x.length}
    distance = 0
    comps[0].chars.each_with_index do |char, idx|
      distance += char != comps[1][idx] ? 1 : 0
    end
    distance
  end

end

# dna = DNA.new('ABCDE')

# p dna

# p dna.hamming_distance('ABCDFE')
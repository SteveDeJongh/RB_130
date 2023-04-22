##### RB 130 Challenges Anagrams #####

=begin
Rules:


=end

class Anagram
  def initialize(word)
    @word = word
  end

  def match(comps)
    comps.select do |curr|
      curr.chars.all? do |char|
        char.count(curr) == char.count(@word)
      end
    end
  end

end

# detector = Anagram.new('tan')

# p detector

# p detector.match(['nat', 'tna'])
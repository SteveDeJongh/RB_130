##### RB 130 Challenges Anagrams #####

=begin
Rules:
Anagrams are case insensitive
Identical words are not anagrams



=end

class Anagram
  def initialize(word)
    @word = word
  end

  def match(comps)
    comps.select do |curr|
      curr.chars.all? do |x|
        let = x.downcase
        curr.downcase.count(let) == word.count(let)
      end &&
      curr.downcase != word &&
      curr.size == @word.size
    end
  end

  private

  def word
    @word.downcase
  end

end

# detector = Anagram.new('galea')

# p detector

# p detector.match(['eagle'])
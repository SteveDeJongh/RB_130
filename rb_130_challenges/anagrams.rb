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
      p curr.chars
      curr.chars.all? do |char|
        letter = char.downcase
        p "#{letter.count(curr.downcase)} #{letter} in #{curr}"
        p "main word #{letter.count(@word.downcase)} #{letter}"
        letter.count(curr.downcase) == letter.count(@word.downcase)
      end &&
      curr.downcase != @word.downcase &&
      curr.size == @word.size
    end
  end

end

detector = Anagram.new('galea')

# p detector

p detector.match(['eagle'])
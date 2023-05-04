##### RB 130 Challenges Anagrams #####

=begin
Rules:
Anagrams are case insensitive
Identical words are not anagrams

=end

# class Anagram
#   def initialize(word)
#     @word = word.downcase
#   end

#   def match(comps)
#     comps.select do |curr|
#       curr.chars.all? do |x|
#         let = x.downcase
#         curr.downcase.count(let) == word.count(let)
#       end &&
#         curr.downcase != word &&
#         curr.size == word.size
#     end
#   end

#   private

#   attr_reader :word
# end

# detector = Anagram.new('galea')

# p detector

# p detector.match(['eagle'])

# Alternate solution:

class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(comps)
    comps.select do |ana|
      anagram?(ana) && ana.downcase != @word
    end
  end

  private

  def sorted_word(wrd)
    wrd.downcase.chars.sort
  end

  def anagram?(comp)
    sorted_word(@word) == sorted_word(comp)
  end
end

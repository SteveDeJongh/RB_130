##### RB 130 Challenges Scrable Score #####

=begin
PEDAC

Letter	= Value
A, E, I, O, U, L, N, R, S, T	= 1
D, G	= 2
B, C, M, P = 3
F, H, V, W, Y =	4
K	= 5
J, X =	8
Q, Z	= 10

Problem:
Compute the total score for each word.
letter matches are case insensitive
each letter accumulates its own score
letter scores are summed
tab and newline characters should be ignored

Examples:
Cabbage = 14

Data:
Arrays, Hashes, integers, and strings

Algorithm:
initialize hash to contain the key as the score for the letter, with the value an array of the letters for that score.

Create a new "scrabble" class.
 constructor method takes a string, upcases it, and stores it in @word

 define `score` method
   initialize `score` local variable to 0
   iterate over characters in word
     
   


Code:

=end

SCORES = { A: 1, E: 1, I: 1, O: 1, U: 1, L: 1, N: 1, R: 1, S: 1, T: 1, D: 2, G: 2, B: 3, C: 3, M: 3, P: 3,
           F: 4, H: 4, V: 4, W: 4, Y: 4, K: 5, J: 8, X: 8, Q: 10, Z: 10}

# p SCORES

class Scrabble
  def initialize(word)
    @word = word
  end

  def score
    return 0 if @word == nil
    word = @word.strip.upcase
    result = 0

    word.chars.each {|char| result += SCORES.fetch(char.to_sym)}
    result

  end

  def self.score(input)
    return 0 if input == nil
    word = input.upcase
    result = 0

    word.chars.each {|char| result += SCORES.fetch(char.to_sym)}
    result
  end

  private

  # attr_reader :word
end

test1 = Scrabble.new('cabbage')

p test1
p test1.score
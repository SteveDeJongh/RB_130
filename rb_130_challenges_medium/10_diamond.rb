##### RB 130 Challenges 10 Diamond #####

=begin

The first row contains one 'A'.
The last row contains one 'A'.
All rows, except the first and last, have exactly two identical letters.
The diamond is horizontally symmetric.
The diamond is vertically symmetric.
The diamond has a square shape (width equals height).
The letters form a diamond shape.
The top half has the letters in ascending order.
The bottom half has the letters in descending order.
The four corners (containing the spaces) are triangles.

Requirements:
Diamond Class
  make_diamond(arg) method

initialize array of upper case alphabetical letters
establish max text width
create new 'line' for each letter, centered in max width
unless letter is "A", add array index of spaces between two instances of the letter


=end

class Diamond
  def self.make_diamond(letter)
    letters = ('A'..letter).to_a + ('A'...letter).to_a.reverse # Initializing array of letters.
    width = self.findwidth(letter) # Finding max text width for centering lines.
    
    letters.each_with_object([]) do |let, arr|
      arr << make_a_row(let).center(width)
    end.join("\n") + "\n"
  end

  private

  def self.make_a_row(letter)
    return "A" if letter == "A"
    return "B B" if letter == "B"

    letter + determine_spaces(letter) + letter # Returns string of "Letter (x number of spaces) letter"
  end

  def self.determine_spaces(letter)
    all_letters = ['B']
    spaces = 1

    until all_letters.include?(letter)
      current_letter = all_letters.last
      all_letters << current_letter.next
      spaces += 2
    end

    " " * spaces # Returns string of spaces
  end

  def self.findwidth(letter)
    return 1 if letter == "A"

    determine_spaces(letter).count(" ") + 2 # returns count of spaces + 2 (for letters on either end)
  end
end

p Diamond.make_diamond("B")
##### RB 130 Challenges Octal #####

=begin

Problem:
Convert Octal number to decimal number.
valid digits only contain numbers from 0-7

To convert octal to decimal, each digit is multiplied by 8 to the exponent of their position in the
digit less 1.

#Octal::to_decimal

split string input into characters.
Reverse characters array to be able to use index
initialized result array
iterate over each digit in characters array with index
multiply character converted to integer by the result of 8 * index
return sum of those numbers

=end

class Octal
  attr_reader :octal

  def initialize(octal)
    @octal = octal
  end

  def to_decimal
    digits = octal.chars.reverse
    return 0 if invalid_octal?(digits) # Moved code to a helper method.
    # return 0 if digits.any?{|x| x=~ /[a-zA-Z89]/ } # Checking for invalid characters/digits
    digits.map.with_index do |dig, idx|
      dig.to_i * (8**idx)
    end.sum
  end

  private

  def invalid_octal?(num)
    num.any?{|x| x=~ /[a-zA-Z89]/ }
  end
end

num = Octal.new('a10')

p num.to_decimal
##### RB 130 Challenges Roman Numerals #####

=begin
Problem:
Roman numerals:
I = 1
V = 5
X = 10
L = 50
C = 100
D = 500
M = 1000

Placing any smaller number infront of any larger number indicates subtraction ie: IV = 4 (5 - 1), IX = 9 (10 - 1)
Do not have to worry aobut numbers higher than 3000.
Roman numerals are written by expressing each digit of the number seperately, starting from the left most digit and skipping any 0s

Examples:
Need:
  a constructor that accepts non-roman integer numbers as an argument
  a to_roman method that returns the Roman numeral representation of that number as a string.

Data:
Input: Integer
Output: String

Alogrithm:

Constructor:
Accept a number as an argument

Roman Numerals Collection:
Create a colection that links important Roman numeral strings to their numeric counterparts.
ensure this is in descending order.

Method:
initilaize a varible with an empty string
iterate over the roman numerals collection:
  if the numeric value of the current Roman numerial is less than the value of the input number, add the roman
  numerlas to the string as many times as its value can fit. For instnace, if the current roman numeral is C (Which is 100),
  and the input number is 367, then 3 C's are needed: CCC.

  Subtract the numeric value of the added Roman numerals from the current inptu value, and use the input value in subsequent iterations.
  For instance, since we added CCC to the string above, we must subtract 300 from 367, leaving us with a new input number 67.

return result string.

=end

NUMERALS = {"M" => 1000, "CM" => 900, "D" => 500, "CD" => 400, "C" => 100, "XC" => 90, "L" => 50, "XL" => 40,
            "X" => 10, "IX" => 9, "V" => 5, "IV" => 4, "I" => 1}

class RomanNumeral
  def initialize(num)
    @number = num
  end

  def to_roman
    result = ""
    curr_num = @number
    NUMERALS.each do |k, v|
      number = curr_num
      loop do
        if v <= number
          result << k
          number -= v
        else
          break
        end
      end
      curr_num = number
    end

    result
  end
end

firsttest = RomanNumeral.new(1000)

p firsttest.to_roman
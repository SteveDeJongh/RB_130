##### RB 130 Challenges Series #####

=begin

Input: String of digits, and length
Output: all possible conescutive number series of a specified length,
inthe form of a nested array
  of single digits. ie: ('1234', 2') = [[1,2],[2,3],[3,4]]

Raise an error if asked for a series longer than the input string

Series Class
constructor
slices method

=end

class Series
  attr_reader :digits

  def initialize(string)
    @digits = string.chars.map(&:to_i)
  end

  def slices(count)
    raise ArgumentError if count > (digits.size)
    # result = []
    # idx = 0
    # while idx + count < digits.size + 1
    #   result << digits.slice(idx, count)
    #   idx += 1
    # end
    # result
    digits.each_cons(count).to_a
    # Much cleaner way to create the consecutive number arrays.
  end
end

# dig = Series.new('1234')

# p dig.digits
# p dig.slices(5)

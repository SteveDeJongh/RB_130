##### RB 130 Challenges Sum of Multiples #####

=begin

SumOfMultiple#num
iterate from 0 to num - 1
  if iterator evenly divides any of the multiples, return num
    if iterator doesn't return 0
sum numbers

=end

class SumOfMultiples
  attr_reader :multiples
  @@defaults = [3,5]

  def initialize(*multiples)
    @multiples = (multiples.size > 0) ? multiples : [3,5]
  end

  def to(num)
    (0..(num-1)).to_a.map do |curr|
      @multiples.any? {|x| curr % x == 0} ? curr : 0
      # if @multiples.any? {|x| curr % x == 0}
      #   curr
      # else
      #   0
      # end
    end.sum
  end

  # My initial solution using a class variable.

  # def self.to(num)
  #   (0..(num-1)).to_a.map do |curr|
  #     @@defaults.any? {|x| curr % x == 0} ? curr : 0
  #     # if @@defaults.any? {|x| curr % x == 0}
  #     #   curr
  #     # else
  #     #   0
  #     # end
  #   end.sum
  # end

  # Alternate class method, instantiating a new SumOfMultiples Object.

  def self.to(num)
    SumOfMultiples.new().to(num)
  end
end

# num = SumOfMultiples.new

# p num.multiples

# p SumOfMultiples.to(3)
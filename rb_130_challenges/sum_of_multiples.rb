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
    @multiples = multiples
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

  def self.to(num)
    (0..(num-1)).to_a.map do |curr|
      # @@defaults.any? {|x| curr % x == 0} ? curr : 0
      # if @@defaults.any? {|x| curr % x == 0}
      #   curr
      # else
      #   0
      # end
    end.sum
  end

end

num = SumOfMultiples.new

p num.multiples

p SumOfMultiples.to(3)
##### RB 130 Challenges Triangles #####

class Triangle
  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3].sort
    raise ArgumentError unless legal?
  end

  def kind
    sides = @sides
    return "equilateral" if sides[0] == sides[1] && sides[0] == sides[2]
    return "isosceles" if sides.uniq.size == 2
    "scalene"
  end

  private

  def legal?
    sides = @sides
    return false if (sides[0] + sides[1]) <= sides[2]
    return false if sides.any? { |side| side <= 0.0 }
    true
  end
end

=begin

# Launch School solution

class Triangle
  attr_reader :sides

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    raise ArgumentError.new "Invalid triangle lengths" unless valid?
  end

  def kind
    if sides.uniq.size == 1
      'equilateral'
    elsif sides.uniq.size == 2
      'isosceles'
    else
      'scalene'
    end
  end

  private

  def valid?
    sides.min > 0 &&
    sides[0] + sides[1] > sides[2] &&
    sides[1] + sides[2] > sides[0] &&
    sides[0] + sides[2] > sides[1]
  end
end

=end

# triangle1 = Triangle.new(1,1,2)

# p triangle1.kind
# p triangle1.legal?

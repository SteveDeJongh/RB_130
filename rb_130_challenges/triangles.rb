##### RB 130 Challenges Triangles #####

class Triangle
  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
  end

  def kind
    sides = @sides.sort
    # return :invalid if (sorted_measurements[0]+sorted_measurements[1]) < sorted_measurements[2]
    # return "invalid" if num1 <= 0 || num2 <= 0 || num3 <= 0
    return "equilateral" if sides[0] == sides[1] && sides[0] == sides[2]
    return "isosceles" if sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]
    return "scalene" if sides[0] != sides[1] && sides[0] != sides[2] && sides[1] != sides[2]  
  end

end

triangle1 = Triangle.new(1,2,3)

p triangle1.kind
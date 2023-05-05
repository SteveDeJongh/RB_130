##### RB 130 Challenges Robot Name #####

=begin
-Robot names can not be used twice
-Robot names are made up of 2 upper case letters, followed by 3 digits
-Robot names are initialied on "first boot up"
-Reseting a robot wipes it's name, and it gets reinitialized
 next time it's used.
-

Class Robot
  initialize method
  reset method
  name accessor

=end

class Robot
  attr_accessor :name

  @@used_names = []

  def initialize
    @name = generate_name
  end

  def reset
    @@used_names.delete(name)
    self.name = generate_name
  end

  private

  LETTERS = ('A'..'Z').to_a
  DIGITS = ('0'..'9').to_a

  def generate_name
    name = ""
    loop do
      2.times { |_| name << LETTERS.sample }
      # could/should have used `array#sample` as well.
      3.times { |_| name << DIGITS.sample }
      break unless @@used_names.include?(name)
      name = ""
    end

    @@used_names << name
    name
  end
end

# My solution passes the tests, however doesn't quite fit the problems
# requirements of only initializing the @name when the robot is
# "turned on". It also does not put the old robot name back into the
# mix of available names when the name is reset.

# LS Solution

# class Robot
#   @@names = []

#   def name
#     return @name if @name
#     @name = generate_name while @@names.include?(@name) || @name.nil?
#     @@names << @name
#     @name
#   end

#   def reset
#     @@names.delete(@name)
#     @name = nil
#   end

#   private

#   def generate_name
#     name = ''
#     2.times { name << rand(65..90).chr }
#     3.times { name << rand(0..9).to_s }
#     name
#   end
# end

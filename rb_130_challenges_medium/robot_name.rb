##### RB 130 Challenges Robot Name #####

=begin
-Robot names can not be used twice
-Robot names are made up of 2 upper case letters, followed by 3 digits
-Robot names are initialied on "first boot up"
-Reseting a robot wipes it's name, and it gets reinitialized next time it's used.
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
    @@used_names << @name
  end

  def reset
    self.name = generate_name
  end

  private

  def generate_name
    letters = ('A'..'Z').to_a
    digits = ('0'..'9').to_a

    name = ""
    loop do

      2.times do |_|
        name << letters.shuffle[0]
      end

      3.times do |_|
        name << digits.shuffle[0]
      end
      break unless @@used_names.include?(name)
    end

    name
  end

end

# robot = Robot.new

# p robot
# robot.reset
# p robot
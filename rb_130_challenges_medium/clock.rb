##### RB 130 Challenges Clock #####

=begin

Create a clock that is independent of date.
Create new clock instance when adding to or subtracting minutes
2 clocks objects that represent the same time should be equal

Class Clock

Methods:
class:
  at (hours, minutes)
instance
  + (minutes)
  - (minutes)
  ==
  to_s



=end

class Clock
  attr_accessor :time

  def initialize(hours, min)
    @time = "#{"%02d" % hours}:#{"%02d" % min}" # format output to include leading 0's.
  end

  def self.at(hours, min = "00")
    Clock.new(hours, min)
  end

  def +(minutes)
    local_time = self.time
    hr, min = local_time.split(':').map(&:to_i)
    inchr, incmn = (minutes + min).divmod(60)
    _, inchr = (hr + inchr).divmod(24)

    Clock.new(inchr, incmn)
  end

  def -(minutes)

  end

  def ==(other)
    self.time == other.time
  end

  def to_s
    self.time
  end

end

cl = Clock.at(10, 30)
cl2 = Clock.at(10, 30)
p cl
p cl + 1660

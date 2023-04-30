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

# My Solution

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
    self.+(-minutes)
  end

  def ==(other)
    self.time == other.time
  end

  def to_s
    self.time
  end

end

# LS Solution

# class Clock
#   attr_reader :hour, :minute

#   ONE_DAY = 24 * 60

#   def initialize(hour, minute)
#     @hour = hour
#     @minute = minute
#   end

#   def self.at(hour, minute=0)
#     new(hour, minute)
#   end

#   def +(add_minutes)
#     minutes_since_midnight = compute_minutes_since_midnight + add_minutes
#     while minutes_since_midnight >= ONE_DAY
#       minutes_since_midnight -= ONE_DAY
#     end

#     compute_time_from(minutes_since_midnight)
#   end

#   def -(sub_minutes)
#     minutes_since_midnight = compute_minutes_since_midnight - sub_minutes

#     while minutes_since_midnight < 0
#       minutes_since_midnight += ONE_DAY
#     end

#     compute_time_from(minutes_since_midnight)
#   end

#   def ==(other_time)
#     hour == other_time.hour && minute == other_time.minute
#   end

#   def to_s
#     format('%02d:%02d', hour, minute);
#   end

#   private

#   def compute_minutes_since_midnight
#     total_minutes = 60 * hour + minute
#     total_minutes % ONE_DAY
#   end

#   def compute_time_from(minutes_since_midnight)
#     hours, minutes = minutes_since_midnight.divmod(60)
#     # hours %= 24
#     self.class.new(hours, minutes)
#   end
# end


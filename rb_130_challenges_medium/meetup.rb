##### RB 130 Challenges Meetup #####

=begin

Construct Meetup objects that represent a meetup date
Each meetup object takes a month number, and a year

Class Meetup
  constructor
  day(day, number)




=end

require 'date'

class Meetup

  attr_reader :year, :month

  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(day, iteration)
    start = startday(iteration)
    start_day = Date.civil(year, month, start)
    day = whichday(day)

    # puts "start day is #{start_day}"

    result = nil
 
    start_day.upto(lastday(year, month)) do |date|
      result = date.day if date.cwday == day
      break if result != nil && iteration.capitalize != 'Last' 
    end

    @date = result ? Date.civil(year, month, result) : nil
  end

  # private

  def lastday(year, month)
    Date.civil(year, month, -1)
  end

  def whichday(day)
    working_day = day.capitalize

    case working_day
    when "Monday"    then 1
    when "Tuesday"   then 2
    when "Wednesday" then 3
    when "Thursday"  then 4
    when "Friday"    then 5
    when "Saturday"  then 6
    when "Sunday"    then 7
    end
  end

  def startday(itt)
    itt = itt.capitalize
    case itt
    when "First"    then 1
    when "Second"   then 8
    when "Third"    then 15
    when "Fourth"   then 22
    when "Fifth"    then 29
    when "Last"     then 22
    when "Teenth"   then 13
    end
  end
end

# d1 = Meetup.new(2016, 1)


# p d1.day('Saturday', 'fifth')

# p Date.civil(2023, 4, -1).day
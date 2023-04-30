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

    result = nil

    start_day.upto(lastday(year, month)) do |date|
      result = date if date.cwday == day
      break if !result.nil? && iteration.capitalize != 'Last'
    end

    @date = result || nil
  end

  private

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

# LS Solution

class Meetup
  SCHEDULE_START_DAY = {
    'first' => 1,
    'second' => 8,
    'third' => 15,
    'fourth' => 22,
    'fifth' => 29,
    'teenth' => 13,
    'last' => nil
  }.freeze

  def initialize(year, month)
    @year = year
    @month = month
    @days_in_month = Date.civil(@year, @month, -1).day
  end

  def day(weekday, schedule)
    weekday = weekday.downcase
    schedule = schedule.downcase

    first_possible_day = first_day_to_search(schedule)
    last_possible_day = [first_possible_day + 6, @days_in_month].min

    (first_possible_day..last_possible_day).detect do |day|
      date = Date.civil(@year, @month, day)
      break date if day_of_week_is?(date, weekday)
    end
  end

  private

  def first_day_to_search(schedule)
    SCHEDULE_START_DAY[schedule] || (@days_in_month - 6)
  end

  def day_of_week_is?(date, weekday) # rubocop:disable Metrics/CyclomaticComplexity
    case weekday
    when 'monday'    then date.monday?
    when 'tuesday'   then date.tuesday?
    when 'wednesday' then date.wednesday?
    when 'thursday'  then date.thursday?
    when 'friday'    then date.friday?
    when 'saturday'  then date.saturday?
    when 'sunday'    then date.sunday?
    end
  end
end
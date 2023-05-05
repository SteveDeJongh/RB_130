##### RB 130 Challenges Beer Song #####

=begin

Write a program that can generate the lryics of the 99 bottles of beer song.

Requirements:

BeerSong class
  `verse` class method
     method takes a start verse and optional end verse
     returns those lines

  `verses` class method
     method takes a start verse and optional end verse
     returns those lines

   `lyrics` class method
     returns entire song from 99 to 0

Rules:

Verse is:
"99 bottles of beer on the wall, 99 bottles of beer.\n" \
"Take one down and pass it around, 98 bottles of beer on the wall.\n" \
"\n" \

Last Verse (0 bottles):
"No more bottles of beer on the wall, no more bottles of beer.\n" \
"Go to the store and buy some more, 99 bottles of beer on the wall.\n"
=end

# First solution, no very OOO style.

=begin

class BeerSong
  def self.verse(line)
    result = ""
    if line > 2
      result += "#{line} bottles of beer on the wall, #{line} bottles of" +
      "beer.\n" +
      "Take one down and pass it around, #{line - 1} bottles of " +
      "beer on the wall.\n"
    elsif line == 2
      result += "2 bottles of beer on the wall, 2 bottles of beer.\n" +
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    elsif line == 1
      result += "1 bottle of beer on the wall, 1 bottle of beer.\n" +
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    else
      result += "No more bottles of beer on the wall, no more bottles " +
      "of beer.\n" +
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
    result
  end

  def self.verses(start, finish)
    result = ""
    start.downto(finish) do |verse|
      result += "\n" unless verse == start
      result += self.verse(verse)
    end
    result
  end

  def self.lyrics
    self.verses(99, 0)
  end
end

p BeerSong.verse(2)

=end

# A more OOO approach.

class Verse
  attr_reader :bottles

  def initialize(bottles)
    @bottles = bottles
  end

  def single_verse
    case bottles
    when 0 then zero_bottle_verse
    when 1 then single_bottle_verse
    when 2 then two_bottle_verse
    else        default_verse
    end
  end

  private

  def default_verse
    "#{bottles} bottles of beer on the wall, #{bottles}" \
    " bottles of beer.\nTake one down and pass it around, " \
    "#{bottles - 1} bottles of beer on the wall.\n"
  end

  def two_bottle_verse
    "2 bottles of beer on the wall, 2 bottles of beer.\n" \
    "Take one down and pass it around, 1 bottle of beer " \
    "on the wall.\n"
  end

  def single_bottle_verse
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer " \
    "on the wall.\n"
  end

  def zero_bottle_verse
    "No more bottles of beer on the wall, no more bottles " \
    "of beer.\nGo to the store and buy some more, 99 bottles " \
    "of beer on the wall.\n"
  end
end

class BeerSong
  def self.verse(number)
    Verse.new(number).single_verse
  end

  def self.verses(start, stop)
    result = []

    start.downto(stop) do |line|
      result << verse(line).to_s
    end

    result.join("\n")
  end

  def self.lyrics
    verses(99, 0)
  end
end

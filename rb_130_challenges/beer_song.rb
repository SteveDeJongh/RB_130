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

class BeerSong
  def self.verse(start = 99, finish = start)
    result = ""
    start.downto(finish) do |verse|
      result += "\n" unless verse == start
      if verse > 2 
        # puts "#{verse} bottles of beer on the wall, #{verse} bottles of beer."
        # puts "Take one down and pass it around, #{verse - 1} bottles of beer on the wall."
        result += "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" +
        "Take one down and pass it around, #{verse - 1} bottles of beer on the wall.\n"
      elsif verse == 2
        result += "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" +
        "Take one down and pass it around, #{verse - 1} bottle of beer on the wall.\n"
      elsif verse == 1
        result += "#{verse} bottle of beer on the wall, #{verse} bottle of beer.\n" +
        "Take it down and pass it around, no more bottles of beer on the wall.\n"
      else
        result += "No more bottles of beer on the wall, no more bottles of beer.\n" + 
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
      end
    end
    result
  end

  def self.verses(start = 99, finish = start)
    result = ""
    start.downto(finish) do |verse|
      result += "\n" unless verse == start
      if verse > 2 
        # puts "#{verse} bottles of beer on the wall, #{verse} bottles of beer."
        # puts "Take one down and pass it around, #{verse - 1} bottles of beer on the wall."
        result += "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" +
        "Take one down and pass it around, #{verse - 1} bottles of beer on the wall.\n"
      elsif verse == 2
        result += "#{verse} bottles of beer on the wall, #{verse} bottles of beer.\n" +
        "Take one down and pass it around, #{verse - 1} bottle of beer on the wall.\n"
      elsif verse == 1
        result += "#{verse} bottle of beer on the wall, #{verse} bottle of beer.\n" +
        "Take it down and pass it around, no more bottles of beer on the wall.\n"
      else
        result += "No more bottles of beer on the wall, no more bottles of beer.\n" + 
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
      end
    end
    result
  end

  def self.lyrics
    self.verses(99, 0)
  end
end

p BeerSong.verse(2)
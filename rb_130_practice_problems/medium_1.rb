##### RB 130 - Ruby Foundations: More Topics - Medium 1 #####

=begin

# 1) Listening Device

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    record(yield) if block_given?
  end

  def play
    puts @recordings.last
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

# 2) Text Analyzer - Sandwich Code

file = File.open("txtfile.txt")

# p file #=> <File:txtfile.txt>

filetext = file.read
# p filetext (or called `read` called directly on file) #=> full text from file

class TextAnalyzer
  def process
    text = File.open('txtfile.txt', 'r') #('r' flag is to open file as read-only)
    puts yield(text.read) # `read` actually reads the file.
    text.close # Important to close files when finished using them.
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |txt| "#{txt.split("\n\n").size} paragraphs"}
analyzer.process { |txt| "#{txt.split("\n").size} lines"}
analyzer.process { |txt| "#{txt.split(' ').size} words"}

# 3) Passing Parameters Part 1

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(items) {|items| puts "#{items.join(' 00 ')}"}

# 4) Passing Parameters Part 2

birds = %w(crow finch hawk eagle)

def assignment(arr)
  yield(arr)
end

# When yielding an array to a block, ruby assigns individual elements of the array to the different block variables.

assignment(birds) {|_, _, *raptors| puts "Raptors: #{raptors.join(', ')}"}

# '*' (splat operator) tells ruby to assign all remaining elements in the array to the argument.

# 5) Passing Parameters Part 3

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*first_three ,last|
  puts first_three.join(', ')
  puts last
end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

gather(items) do |first1, *middle, last|
  puts first1
  puts middle.join(', ')
  puts last
end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

gather(items) do | first, *last |
  puts first
  puts last.join(', ')
end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

gather(items) do | a, b, c, d|
  puts "#{a}, #{b}, #{c}, and #{d}"
end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!

=end

# 6) Method to Proc

# 7) Buble Sort with Blocks

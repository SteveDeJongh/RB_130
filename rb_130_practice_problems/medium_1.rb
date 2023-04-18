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

# 6) Method to Proc

# Replace the two `method_name` placeholders with actual method calls
# def convert_to_base_8(n)
#   n.method_name.method_name
# end
def convert_to_base_8(n)
  n.to_s(8).to_i
end

# Replace `argument` with the correct argument below
# `method` is `Object#method`, not a placeholder
# base8_proc = method(argument).to_proc
base8_proc = method(:convert_to_base_8).to_proc # Passing a symbol of the method we want to pass to `Object#method`

# We'll need a Proc object to make this code work
# Replace `a_proc` with the correct object
# [8, 10, 12, 14, 16, 33].map(&a_proc)
p [8, 10, 12, 14, 16, 33].map(&base8_proc) == [10, 12, 14, 16, 20, 41]

# 7) Buble Sort with Blocks # Revisit FE

# def bubble_sort!(array)
#   if block_given?
#     loop do
#       swapped = false
#       1.upto(array.size - 1) do |index|
#         next if yield(array[index - 1], array[index])
#         array[index - 1], array[index] = array[index], array[index - 1]
#         swapped = true
#       end
  
#       break unless swapped
#     end
#   else
#     loop do
#       swapped = false
#       1.upto(array.size - 1) do |index|
#         next if array[index - 1] <= array[index]
#         array[index - 1], array[index] = array[index], array[index - 1]
#         swapped = true
#       end

#       break unless swapped
#     end
#   end
# end

# Or essentially moving the `if block_given?` query to occur on each iteration of the collection.

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end

      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

=end
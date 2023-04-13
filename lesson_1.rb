##### Rb 130 Lesson 1: Blocks #####

=begin
# Blocks

[1,2,3].each do |n|
  puts n
end

# or

[1,2,3].each {|x| puts x}

# block syntax using `do...end` or `{...}`

# Passing in a block to `Integer#times` method.

3.times do |num|
  puts num
end

#=> 3 (Returns the calling object 3, outputs 0,1,2)

# Passing a block to the `Array#map` method.

[1,2,3].map do |num|
  num + 1
end

#=> Returns a new array of the manipulated values from the block, [2,3,4]

# Passing in a block to the `Hash#select` method.

{ a: 1, b: 2, c: 3, d: 4, e: 5 }.select do |_, value|
  value > 2
end

#=> Returns a new hash object according the the return value of the block. { c: 3, d: 4, e: 5 }

# Writing Methods that take Blocks

# method implementation
def increment(number)
  if block_given?
    yield(number + 1)
  end
  number + 1
end

# method invocation
increment(5) do |num|
  puts num
end

# Writing our own `times` method.

def times(number)
  counter = 0
  while counter < number do
    yield(counter) # yield to block and pass counter as an argument.
    counter += 1
  end

  number # Return the original method argument to match behavior of `integer#times`
end

times(5) do |num|
  puts num
end

# Writing our own `each` method.

def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])
    counter += 1
  end

  array
end

arr = [1,2,3]

p each(arr) {|x| puts x} #=> Returns [1, 2, 3] , outputs 1 2 3 on seperate lines

# Assignment: Build a `select` method.

def select(array)
  counter = 0
  result = []

  while counter < array.size
    if yield(array[counter])
      result << array[counter]
    end
    counter += 1
  end

  result
end

# My solution required the element lookup twice and can be streamlined by assigned the element to a local variable within
# the `while` loop.

# while counter < array.size
#   curr_element = array[counter]
#   result << curr_element if yield(curr_element)
#   counter += 1
# end

p select([1,2,3]) {|x| x.odd?}

# Assignment: Build a `reduce` method

def reduce(arr, start = 0)
  counter = 0
  accumulator = start

  while counter < arr.size
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end

  accumulator
end

array = [1,2,3,4,5]

p reduce([1,2,3]) { |acc, num| acc + num } #=> 6
p reduce(array) { |acc, num| acc + num } #=> 15
p reduce(array, 10) { |acc, num| acc + num } #=> 25
# p reduce(array) { |acc, num| acc + num if num.odd? } #=> Nomethoderror.

# To add functionality where values could be non-numeric.

def reduce(arr, start = arr[0])
  counter = start == arr[0] ? 1 : 0
  accumulator = start

  while counter < arr.size
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end

  accumulator
end

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
array = [1,2,3,4,5]

p reduce([1,2,3]) { |acc, num| acc + num } #=> 6
p reduce(array) { |acc, num| acc + num } #=> 15
p reduce(array, 10) { |acc, num| acc + num } #=> 25
# p reduce(array) { |acc, num| acc + num if num.odd? } #=> Nomethoderror.

=end

# Assignment: TodoList

# Todo class for todo items and it's data.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end
=begin

# Tests for Todo object class

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

puts todo1 #=> [ ] Buy milk
puts todo2 #=> [ ] Clean room
puts todo3 #=> [ ] Go to gym

todo1.done! # Calls teh Todo#done! method on `todo1` and changes the @done instance variable to true

puts todo1 #=> [X] Buy milk # The string interpolation in the `todo#to_s` method now evaluates to true and returns the `DONE_MARKER`
puts todo2 #=> [ ] Clean room
puts todo3 #=> [ ] Go to gym
=end

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    if item.class == Todo
      todos << item
    else
      raise TypeError.new("Can only add Todo objects")
    end

    # Or
    # raise TypeError, "can only add Todo objects" unless item.instance_of? Todo

    # todos << item
  end

  alias << add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all? {|item| item.done?}
  end

  def item_at(pos)
    if pos <= todos.size
      todos[pos]
    else
      raise IndexError
    end

    # Or using `array#fetch` to raise error
    # todos.fetch(pos)
  end

  def mark_done_at(pos)
    if pos <= todos.size
      todos[pos].done!
    else
      raise IndexError
    end

    # or using `TodoList#item_at` to raise error
    # item_at(pos).done!
  end

  def mark_undone_at(pos)
    if pos <= todos.size
      todos[pos].undone!
    else
      raise IndexError
    end

    # Or using `TodoList#item_at`
  end

  def done!
    todos.each {|item| item.done! }

    # Or using `TodoList#mark_done_at`
    # todos.each_with_index { |idx| mark_done_at(idx)}
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(pos)
    if pos <= todos.size
      todos.delete_at(pos)
    else
      raise IndexError
    end
  end

  def to_s
    puts "------ #{title} ------"
    todos.each { |item| puts item }
  end
end


# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add
# list << (todo3) # test for `<<`

# ---- Interrogating the list -----

# size
p list.size                       # returns 3

# first
p list.first                      # returns todo1, which is the first item in the list

# last
p list.last                       # returns todo3, which is the last item in the list

#to_a
p list.to_a                      # returns an array of all items in the list

#done?
p list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
# p list.item_at                    # raises ArgumentError
p list.item_at(1)                 # returns 2nd item in list (zero based index)
# p list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
# list.mark_done_at               # raises ArgumentError
list.mark_done_at(1)            # marks the 2nd item as done
# list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
list.mark_undone_at(1)          # marks the 2nd item as not done,
# list.mark_undone_at(100)        # raises IndexError

# done!
list.done!                      # marks all items as done

p list

# ---- Deleting from the list -----

# shift
# list.shift                      # removes and returns the first item in list

# pop
# list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym
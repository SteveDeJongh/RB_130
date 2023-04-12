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

=end
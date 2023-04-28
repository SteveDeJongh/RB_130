##### RB 130 - Ruby Foundations: More Topics - Advanced 1 #####

=begin

# 1) Internal vs external Iterators

factorial = Enumerator.new do |yielder|
  accumulator = 1
  number = 0
  loop do
    accumulator = number.zero? ? 1 : accumulator * number
    yielder << accumulator
    number += 1
  end
end

# External iterators

6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="
factorial.rewind
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="

# Internal iterators

factorial.each_with_index do |value, number|
  puts "#{number}! == #{value}"
  break if number >= 5
end

# 2 ) Exploring Procs, Lambdas, and Blocks; Definition and Arity

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc #=> <Proc:encoding of proc ID advanced_1.rb:39>
puts my_proc.class #=> Proc
my_proc.call #=> This is a .
my_proc.call('cat') #=> This is a cat.

# Procs have lenient Arity, meaning we can pass in too many or too few arguments without raising an error. If nothing is
# passed to a proc that requires an argument, then `nil` is assigned to the block variable.
# A new `proc` object can be created with a call of `proc` instead of `proc.new`
# Proc is an object of class `Proc`

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda #=> <Proc:encoding of proc ID advanced_1.rb:51 (lambda)>
puts my_second_lambda #=> <Proc:encoding of proc ID advanced_1.rb:52 (lambda)>
puts my_lambda.class #=> Proc
my_lambda.call('dog') #=> This is a dog.
# my_lambda.call #=> ArgumentError, wrong number of arguments (given 0, expected 1)
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." } #=> NameError, uninitialized constant Lambda

# A new `Lambda` object can be created with a call to `lambda` or `->`, We cannot create a new Lambda object with `Lambda.new`
# A `Lambda` is a different variety of `Proc`
# While a lambda is a Proc, it maintains a separate identity from a plain Proc. This can be seen when displaying a Lambda:
# the string displayed contains an extra "(lambda)" that is not present for regular Procs.
# Lambdas have strict arity, meaning Ruby will raise an error if too few or too many arguments are passed in.

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."} #=> This is a . # Pass method parameter 'animal' to yield to pass to block.
# block_method_1('seal') #=> LocalJumpError, no block given (yield) # add `if block_given?` to yield.

# Blocks have lenient arity, we can pass too many or too few arguments to the block.
# A block passed toa method does not require the correct number of arguments. If a block variable is defined, and no value is
# passed to it, then `nil` will be assigned to that block variable.
# If we have a `yield` and no block is passed, then an error is thrown.

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."} #=> This is a turtle.
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end #=> This is a turtle and a .
# block_method_2('turtle') { puts "This is a #{animal}."} # NameError, undefined local variable `animal`

# Block have lenient arity, we can pass too many or too few arguments to the block.
# Blocks will throw an error if a variable is referenced that doesn't exist in the blocks scope.

# Comparison

# Lambda's are types of Proc's. Technically they are both Proc objects. An implicit block is a grouping of code, a type
# of closure, it is not an Object.

# Lambda's enforce the number of arguments passed to them. Implicit blocks and PRocs do no enforce the number of arguments
# passed in.

=end
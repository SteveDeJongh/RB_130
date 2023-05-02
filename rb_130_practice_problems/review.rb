##### RB 130 Assessment Prep #####

=begin
Written assessment only
Assessment has roughly 20 questions plus the coding challenge.
4 hours to complete test

Topics covered:

Blocks:
Closures, binding, and scope
How blocks work, and when we want to use them.
Blocks and variable scope
Write methods that use blocks and procs
Understand that methods and blocks can return chunks of code (closures)
Methods with an explicit block parameter
Arguments and return values with blocks
When can you pass a block to a method
&:symbol
Arity of blocks and methods

Testing With Minitest:
Testing terminology
Minitest vs. RSpec
SEAT approach
Assertions

Core Tools/Packaging Code:
Purpose of core tools
Gemfiles

=end

=begin

# Code Examples:

# Yielding to a block, and passing in a method parameter to be the block parameter.

def takeablock(method_param)
  yield(method_param)
end

takeablock('method_arg') { |block_param| puts block_param } #=> "method_arg"

# Sandwich code, returning how long it takes the passed in block to run.

def time_entry
  time_before = Time.now
  yield
  time_after = Time.now

  puts "It took #{time_after - time_before} seconds for the block to run."
end

time_entry do
  puts "What's your name?"
  input = gets.chomp
  puts input
end 

usethisvar = "Hello world!"

def usethevarmethod
  puts "Will it be visible?"
  yield
  puts "... so?"
end

secondvar = "Second one!"
thirdvar = '' # If thirdvar was not initialized here before the usertehvarmethod call on line 73, we'd raise an error.

usethevarmethod { puts usethisvar + secondvar + thirdvar } #=> "Hello world!Secondone!"

thirdvar = "numero three!"

usethevarmethod { puts usethisvar + secondvar + thirdvar } #=> "Hello world!Second one!numero three!"

# Blocks have binding scope, meaning that the scope that they bind to the scope that they are defined in. 

def call_pro(proc)
  proc.call
end

name = "Steve"
chunk = Proc.new {puts "hi #{name}"}

call_pro(chunk) #=> hi Steve

name = "Dave"

call_pro(chunk) #=> hi Dave # Proc is aware of the reassignment of `name`, even after the Proc is defined.

# Example of method yielding to block:

def blockmethod
  puts "This is method execution before the block"
  yield if block_given?
  puts "This is method execution after the block"
end

blockmethod #=> Outputs both lines of text, and doesn't yield as no block is given.

blockmethod { puts "From the block!"} #=> Outputs first line, yields to block and outputs text, then ouputs last line.

# Example of method using passed in proc

def usetheproc(passitin)
  passitin.call
end

proc1 = Proc.new { puts "From the proc!" }

usetheproc(proc1) #=> From the proc!

def addone
  number = 0
  Proc.new {number += 1}
end

start1 = addone
start2 = addone
p start1 #=> <Proc:encoding... review.rb:120>
p start1.call #=> 1
p start1.call #=> 2
p start2 #=> <Proc:encoding... review.rb:120> # note: This is a different, new proc from `start1`
p start2.call #=> 1
p start2 #=> Returns the same Proc object as 128

# Passing in a Proc as a block to a method call

# Problem
def call_this
  yield(2)
end

# Expected outcome:
p call_this(&to_s) #=> 2
p call_this(&to_i) #=> "2"

# As we are not passing in the symbols `:to_s` and `to_i`, but instead variables, we can define these as custom Procs
# before method invocation.

to_i = Proc.new { |num| num.to_s }
to_s = Proc.new { |num| num.to_i }

# The `&` prepending the method argument at invocation time will turn the argumnent into a block.

=end
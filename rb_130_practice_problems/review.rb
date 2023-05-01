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

=end
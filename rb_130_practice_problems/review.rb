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

# Yielding to a block, and passing in a method parameter to be the block parameter.

def takeablock(method_param)
  yield(method_param)
end

takeablock('method_arg') { |block_param| puts block_param } #=> "method_arg"

def time_entry
  time_before = Time.now
  yield
  time_after = Time.now

  puts "It took #{time_after - time_before} seconds."
end

time_entry do
  puts "What's your name?"
  input = gets.chomp
  puts input
end 
##### RB 130 Assessment Prep #####

=begin
Written assessment only
Assessment has roughly 20 questions plus the coding challenge.
Coding challenge same style as the practice problems/coding challenges. Important to check test cases for any
implicit requirements not listed explicitely. Prepare to spend up to an hour on the coding challenge. Recommended to do
10 practice problems from the easy set, and at least 3 from the medium set.
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

##########################################################################################
############################## RB 130 Study Questions ####################################
##########################################################################################

BLOCKS
1, What are closures?

- A closure is a generel programming concept that allows us to save chunks of code that
- we can execute at a later time.

2, What is binding?

- A binding is the reference to the environment/surroudings in which a chunk of code (closure)
- has been defined within. As closures are binding, they track the variables, methods, etc.
- that are within scope at the time of definition. The chunks of code retain references to its surrounding
- artifacts.

3, How does binding affect the scope of closures?

- Binding affects the scope of closures as these chunks of code have access to all surrounding
- artifacts of where it was initially defined. This is important to remember when name
- block parameter to avoid un intentional variable shadowing. Because of binding, closures
- can also change the values of a variable in a different scope from where the block is executed.

4, How do blocks work?

- Every method in Ruby can take an implicit block. We can do so by defining the block as a `do..end`
- or `{...}` block. To use the block, within the method definition we must `yield` to the block.
- We can use `block_given?` to only `yield` to a block if one is passed in.

5, When do we use blocks? (List the two reasons)

We use a block to leave implementation details to the method user.

Say we had a method to compare text before and after some operation was done, but that operation
is left up the method caller.
=end
def compare(input)
  first = input
  second = yield if block_given?
  puts "First: #{first} second: #{second}"
end

compare("Hello!") { "Hello!".upcase} #=> "first: Hello! second: HELLO!"
compare("Hello!") { "boo"} #=> "first: Hello! second: boo"
=begin

Another time to use blocks would be track before and after block execution, tracking how long
it takes for a block to execute is an example. Another good example is when you need to run some 
set up and clean up operations before/after a block is executed, opening and closing a file
for example.

def track_time
  start = Time.now
  yield if block_given?
  finish =  Time.now

  puts "It took #{finish - start} seconds to run."
end

track_time do
  puts "What's your name?"
  answer = gets.chomp
end

#=> It took _____ seconds to run.

6, Describe the two reasons we use blocks, use examples.

- We use blocks when we want to leave final implementation of the method to method invocation time
- When we have methods that we want to perform some "before" and "after" actions, also known as
- sandwhich code.

7, When can you pass a block to a method? Why?

- We can pass a block to a method whenever we want, as all methods take a implicit block.

- All methods regardless of it definiton, take an implicit block. It may ignore it, but still accepts it.
- Blocks can also be passed in via an explicit block parameter ( a parameter name starting with the &)

8, How do we make a block argument manditory?

- To make a block argument manditory, we must explicitely request one in the method's parameter definitons
- by appending the & to a parameter name. The `&` before the parameter name takes the block
- and converts it to a Proc object.

=end

def explicit(&givemeablock)
  givemeablock.call
  givemeablock.call
end

explicit { puts "hello world!"}  #=> hello world! x 2

=begin

9, How do methods access both implicit and explicit blocks passed in?

  Methods access implicit blocks by yielding to them, and explicit blocks by calling the block name.

=end

def implicit
  yield
end

implicit { puts "Yielding to implicit block!"}

def explicit_block(&explicit)
  explicit.call
end

explicit_block { puts "From the explicit block!" }

=begin

10, What is yield in Ruby and how does it work?

`Yield` is a ruby keyword, and diverts method execution to the passed in block as method invocation time.

11, How do we check if a block is passed into a method?

To check if block is passed in to a method, we can use block_given? witch returns true or false depending on if a block
is passed in.

12, Why is it important to know that methods and blocks can return closures?

As a closure is binding, the return closure from a method or block will maintain a copy of it's environment and artifacts, and 
on every subsequent call of the returned closure, it will be working with that environment.

Take the following:
=end

def keep_increasing
  count = 0
  Proc.new { count += 1 }
end

val1 = keep_increasing
p val1 #=> <Proc:encoding...>
p val1.call #=> 1
p val1.call #=> 2

val2 = keep_increasing
p val2.call #=> 1 # new proc object created from the initial environment in keep_increasing

=begin

13, What are the benifits of explicit blocks?

Explicit blocks have the benefit of beign attached to a name within the method. This lets it be re-assigned, passed to another method
or invoked multiple times. 

14, Describe the arity differences of blocks, procs, methods and lambdas.

Blocks and Procs have lenient arity, meaning that they wont complain if too few or too many arguments are passed in.
Methods and lambdas have strict arity, meaning they will raise an error if the number of arguments does not line up.

15, What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

Procs have lenient arity while lambda's use strict arity.
The return statement in a lambda stop the lambda and returns control to the calling code, The return statement in a proc
returns from both the proc and the calling code.

16, What does & do when in a the method parameter?

def method(&var); end

The `&` ahead of a method parameter at method definition tells the method to assign the passed in block to this parameter name.
The block is converted to a simple `proc` objet and assigned tied to the name.

17, What does & do when in a method invocation argument?

method(&var)

At method invocation, the & tells ruby to convert the passed in proc to a block, and pass the block in.

Example:

=end

def output
  yield("output")
end

cap = :capitalize.to_proc # uses symbol#to_proc, to convert the symbol to a proc.

p output(&cap) #=> Output # Not the uppercase O, ruby converts the passed in the proc to a block, which is yielded to in the method definition.

=begin

18, What is happening in the code below?

arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`

Ruby first tries to convert the `:to_s` to a block, but as it's not a Proc, we first call `Symbol#to_proc`. Now that it's a Proc,
ruby then converts this proc to a block.

19, How do we get the desired output without altering the method or the method invocations?
=end
def call_this
  yield(2)
end

# your code here

to_s = Proc.new { |num| num.to_i }
to_i = Proc.new { |num| num.to_s }

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"

=begin

20, How do we invoke an explicit block passed into a method using &? Provide example.

To invoke a explicit block passed in to a method, we have to invoke `call` on the method parameter.

21, What concept does the following code demonstrate?

def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end

This demonstrates sandwich code, performing some `before` block execution and `after` block execution actions.

22, What will be outputted from the method invocation block_method('turtle') below? Why does/doesn't it raise an error?

def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end

# outputs #=> "This is a turtle and a ." # block parameter `seal` is `nil` as `yield` only passed 1 argument.

# 23, What will be outputted if we add the follow code to the code above? Why?

# block_method('turtle') { puts "This is a #{animal}."} # Raises an undefined local variable `animal` error.
# The method parameter `animals` is not visible within the block, and nor is it assigned to the block.

# 24, What will the method call call_me output? Why?

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code) #=> hi Griffin

# As the `name` varaible is initialized before the `chunk_of_code` proc is created, the variable is within scope and the procs
# `binding`. If `name = 'Robert'` was removed, this would raise a NameError, undefined local variable or method 'name`.

25, What happens when we change the code as such:

def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)

# This raises a `NameError` due to `name` not being initialized before the Proc object was created.

26, What will the method call call_me output? Why?


def call_me(some_code)
  some_code.call
end

def name
  "Joe"
end

name = "Robert"

chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code) #=> hi robert

# As Ruby searches for matching variable names first, we find "Robert" and assign it within the block.

# 27, Why does the following raise an error?

def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)

# This will raise an error as Ruby is not able to convert a string to a block object. As `&a' is expecting a to be a proc.

28, Why does the following code raise an error?

def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)

# This raises an error because we can not assign blocks to a variable.

29, Why does the following code output false?

def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)

# This outputs false as we are not passing in a block, but a proc object. If we wanted this to return true, we could append a block
# after the argument.

# 30, How do we fix the following code so the output is true? Explain

def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc, &bloc) #{ add a block here }

# In order to still meet the argument requirements, we leave the passed in argument as is but add an implicit block after for
# the block_given? call to return true.

# We can also append the argument with an explicit `&bloc` argument, which converts the proc to a block, and returns true.

31, How does Kernel#block_given? work?

# Kernel#block_given? works by checking the method implementation for a passed in block. If it finds one, it returns true, otherwise
# it returns false.

32, Why do we get a LocalJumpError when executing the below code? & How do we fix it so the output is hi? (2 possible ways)

def some(block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(bloc)

# This results in a localjumperror as we are not passing in a block, but a proc object as the argument.

# To fix this we can either:
# append a & to both the parameter and the argument.
# or we can use Proc#call instead of yield on line 500. `block.call`
# or pass the block implicitely by adding { p "hi" } after the method arguments.

33, What does the following code tell us about lambda's? (probably not assessed on this but good to know)

bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda

# The code tells us that we use different syntax when creating a Lambda, and that Lambda.new can not be called.
# it also shows that a lambda is a type of the proc class.

34, What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assessed on this, but good to know ;)

def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."

When we call `return` with from a lambda, we only return from the lambda and not the calling code, when we return from a proc,
we also return from the calling code.

35, What will #p output below? Why is this the case and what is this code demonstrating?
=end
def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

arr = retained_array
arr.call('one')
arr.call('two')
p arr.call('three')

# returns an array ['one', 'two', 'three']

# This code demonstrates that closures are binding. As the proc returned from retained array and assigned to `arr` maintains
# reference to the variables inside of `retained_array`, the array being built and returned by the proc is the same array,
# keeps adding the string arguments passed to each call of the proc.

# On each execution of the proc, the argument passed to call is assigned to block parameter `el` which gets added to `arr`

=begin

TESTING WITH MINITEST
36, What is a test suite?

A test suite is the entire set of tests that accompanies tour program or application. This can be thought of all the 
tests for a project.

37, What is a test?

This describes a sitaution or context in which tests are run. For example, a test about making sure an error message is
returned after trying to log in with teh wrong password. A test can ocntain multiple assertions.

38, What is an assertion?

An assertion is the actual verification step to confirm the data returned by your program is indeed what is expected.
A test can contain one or more assertions.

39, What do testing framworks provide?

The main benefit of using a testing framework is to prevent regression. When we make changes to our code, we want to ensure
that these changes do not negatively impact the rest of our code or break some functionality.

40, What are the differences of Minitest vs RSpec

RSpec exclusively uses expectation style syntax, while Minitest can use either assert-style or expecatation style. Minitest
is Ruby's default testing library despite many people using RSpec.

41, What is Domain Specific Language (DSL)?

A domain specific language is a language with a higher lever of abstraction which is optimized for the specific class of problems.
A DSL reads more like plain english that code.

42, What is the difference of assertion vs refutation methods?

Assertion methods are those which ensure that the output matches the passed in expected result.
Refutation methods that ensure that the ouput DOES NOT match the passed in result.

43, How does assert_equal compare its arguments?

Assert equal uses `==` to compare the two arguments and uses the return value of `==` to return a pass or fail.

44, What is the SEAT approach and what are its benefits?

The SEAT approach is where we; set up the neccesary objects using a setup method, execute the code against the object were testing,
assert that hte excuted code did the right thing, and then tearing down and cleaning up any lingering artifacts using a `teardown`
method.

45, When does setup and tear down happen when testing?

Set up occurs before each test, and teardown occurs after each test.

46, What is code coverage?

Code coverage is the measurement of how much of our actual program is tested by a test suite. Code coverage is measured
by how many of our methods are covered in testing, all methods are included in this calculation and not just public methods.

47, What is regression testing?

Regression tests check for bugs that occur in formerly working code after you make changes somewhere in the codebase.
Using tests to identify these bugs means we don't have to verify that everything works manually after each change.

CORE TOOLS
48, What are the purposes of core tools?

The purpose of core tools is to assist in the building of professional, ready for distribution Ruby projects.

49, What are RubyGems and why are they useful?

Ruby Gems are packages of code that yoy cna download, install, and use in you rRuby programs or from the command line.
The gems allow us to easily add more funcitonality to our programs quickly.

50, What are Version Managers and why are they useful?

Ruby version managers are programs that let you install, manage, and use different versions of Ruby. Rbenv, and RVM are 
examples of different ruby version managers.

51, What is Bundler and why is it useful?

Bundler is a gem for ruby that is a dependency manager used to configure which ruby and which gems each of your projects need.

Bundler relies on a Gemfile to tell it which version of Ruby and its Gems it should use. This file is a simple Ruby program
that uses a DSL to provide detailsa bout the Ruyb and Gem versions.

When you run `bundle install`, bundler creates a `gemfile.lock` in your project directory.

52, What is Rake and why is it useful?

Rake is a ruby gem that automates many common funcitons required to build, test,a nd install programs. It's part of
every modern installation of Ruby.

53, What constitues a Ruby project?

A ruby project is/are programs and libraries that make use of Ruby as the primary development language. Each ruby project
is typically designed to use a specific version of Ruby, and may alos use a variety of different Gems.

=end
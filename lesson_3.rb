##### Rb 130 Lesson 3: Packaging Code Into a Project #####

# Ruby Toolbox, notes in RB 130 notion page.

# RB 130 SPOT Study session

# Just a written assessment for RB130
# Lesson 1 is main focus on assessement, but lesson 2 and 3 are on the test as well.
# Coding challenge needs to pass rubocop, rubocop file from RB 120

=begin

Closures

Blocs
Block can be converted to a block.
Procs
Lambdas

=end

square = Proc.new {|x| x **2}

p square.call(2) #=> 4

anothermethod = Proc.new {|x| timestwo(x)}

def timestwo(x)
  x * 2
end

p anothermethod.call(2)

def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

arr1 = retained_array
arr1.call('A')
arr1.call('B')
p arr1.call('C') #=> ['A', 'B', 'C']

arr2 = retained_array
p arr2.call(1) #=> [1]

# Transforms the block to a proc.

def block_to_proc(&b)
  yield b
  b.call
end

name = 'Steve'

block_to_proc { puts name }
#=> Steve
#=> Steve

# Because `name` is initialized before the block, it's within scope and can be used.

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code) #=> Hi Griffin # Procs track the latest assignment to teh variable,
# but the variable needs to be initialized before the proc.

# def a_method(pro)
#   pro.call
# end

# a = 'friend'
# a_method(&a) #=> Raises an error, wrong argument type string (expected proc). Looking to call a `to_proc`

def a_method(&pro)
  pro.call
end

a = proc { 'friend' }
p a_method(&a) #=> friend

###

def some_method(&block) # added &
  block_given?
end

bloc = proc { puts "hi" } # without altering this line, how can we get
                          # an output of ‘true’?
p some_method(&bloc) # added &

##

def some(&block) # added &
  yield
end

bloc = proc {p 'hi' } # Do not alter

some(&bloc) # raises a no block error. # added & for solution

# "&" Method invocation argumetns to blocks (A->B)
# "&" Method definition parameter to proc (PP)

def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end

#=> This is a turtle and a .

def block_method(animal, an2, an3)
  yield(animal, an2, an3)
end

block_method('turtle', 'seal', 'shark') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end

#=> This is a turtle and a seal. # block parameters are assigned in order, and extra argumetns are ignored.

def block_method(animal)
  yield(animal)
end

block_method('turtle') {|animal| puts "This is a #{animal}."}

####

def block_method(animal1)
  animal = "seal" # not in scope to the block
  yield(animal1)
end

animal = 'seal' # in scope for the block

block_method('turtle') {  puts "This is a #{animal}."}
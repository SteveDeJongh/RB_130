##### RB 130 - Ruby Foundations: More Topics - Easy 2 #####

=begin

# 1) From-To-Step Sequence Generator

def step(start, finish, step)
  num = start
  until num > finish
    yield(num)
    num += step
  end
  "Value started at #{start} and finishes with #{finish}."
end

# or

def step(start_point, end_point, increment)
  current_value = start_point
  loop do
    yield(current_value)
    break if current_value + increment > end_point
    current_value += increment
  end
  current_value
end

p step(1, 10, 3) { |value| puts "value = #{value}" }

# 2) Zipper

def zip(ar1, ar2)
  result = []
  ar1.each_with_index do |n, idx|
    result << [n, ar2[idx]]
  end
  result
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

# 3) map

def map(arr)
  result = []
  arr.each {|el| result << yield(el)}
  result
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

# 4) count

def count(*args)
  total = 0
  args.each {|x| total += 1 if yield(x)}
  total
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3

# 5) drop_while

def drop_while(arr)
  index = nil
  arr.each_with_index do |x, idx| 
    if yield(x)
    else
      temp = idx
      index = temp unless index != nil
    end
  end
  index == nil ? [] : arr[index..-1]
end

# Or

def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []

# 6) each_with_index

def each_with_index(col)
  index = 0
  while index < col.size
    yield(col[index], index)
    index += 1
  end
  col
end

# Or

def each_with_index(array)
  index = 0
  array.each do |item|
    yield(item, index)
    index += 1
  end
end


result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]

# 7) each_with_object

def each_with_object(col, obj)
  col.each {|item| yield(item, obj)}
  obj
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}

# 8) max_by

def max_by(col)
  result = []
  col.each {|el| result << yield(el)}
  idx = result.index(result.max)
  col[idx] unless col.empty?
end

# Or

def max_by(array)
  return nil if array.empty?

  max_element = array.first
  largest = yield(max_element)

  array[1..-1].each do |item|
    yielded_value = yield(item)
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil

# 9) each_cons (Part1 )

def each_cons(col)
  times = col.size - 1
  times.times do |n|
    yield(col[n], col[n+1])
  end

  nil
end

# Or using each_with_index and break

def each_cons(array)
  array.each_with_index do |item, index|
    break if index + 1 >= array.size
    yield(item, array[index + 1])
  end
  nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}
p result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
p result == nil

# 10) each_cons (Part 2)

def each_cons(col, num)
  col.each_index do |index|
    break if index + num - 1 >= col.size
    yield(*col[index..(index + num -1)])
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}

=end
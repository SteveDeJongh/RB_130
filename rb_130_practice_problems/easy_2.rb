##### RB 130 - Ruby Foundations: More Topics - Easy 1 #####

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

=end

# 7) each_with_object


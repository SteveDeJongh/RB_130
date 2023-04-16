##### RB 130 - Ruby Foundations: More Topics - Easy 1 #####

=begin

# 1) Enumerable Class Creation

class Tree
  include Enumerable
  
  def each
    ...
  end
end

# 2) Optional Blocks

# def compute
#   if block_given?
#     yield
#   else
#     'Does not compute.'
#   end
# end

# or

def compute
  return 'Does not compute.' unless block_given?
  yield
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'

# FE

def compute(arg)
  return 'Does not compute.' unless block_given?
  yield(arg)
end

p compute(2) { |x| x + 3 } == 5
p compute('a') { |x| x + 'b' } == 'ab'
p compute(2) == 'Does not compute.'

# 3) Find Missing Numbers

def missing(arr)
  result = []
  num = arr.min
  while num < arr.max do 
    result << num unless arr.include?(num)
    num += 1
  end
  result
end

# Or

def missing(arr)
  result = []
  arr.each_cons(2) do |first, last|
    result.concat(((first+1)..(last-1)).to_a)
  end
  result
end

# Or with a block

def missing(arr)
  (arr.min..arr.last).to_a - arr
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []

# 4) Divisors

# def divisors(num)
#   result = []
#   1.upto(num) do |x|
#     result << x if num % x == 0
#   end
#   result
# end

# or using select, method above is fater by ~1s

# def divisors(num)
#   1.upto(num).select do |x|
#     num % x == 0
#   end
# end

# or optimized for larger numbers

def divisors(dividend)
  divisors = []
  quotients = []

  (1..Math.sqrt(dividend)).each do |divisor|
    quotient, remainder = dividend.divmod(divisor)
    if remainder == 0
      divisors << divisor
      quotients.unshift(quotient) unless divisor == quotient
    end
  end

  divisors + quotients
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
p divisors(999962000357)

# 5) Encrypted Pioneers

stringer = 'Nqn Ybirynpr,
Tenpr Ubccre,
Nqryr Tbyqfgvar,
Nyna Ghevat,
Puneyrf Onoontr,
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv,
Wbua Ngnanfbss,
Ybvf Unvog,
Pynhqr Funaaba,
Fgrir Wbof,
Ovyy Tngrf,
Gvz Orearef-Yrr,
Fgrir Jbmavnx,
Xbaenq Mhfr,
Fve Nagbal Ubner,
Zneiva Zvafxl,
Lhxvuveb Zngfhzbgb,
Unllvz Fybavzfxv,
Tregehqr Oynapu'

names = stringer.split(',').map(&:strip)

def rot131(name)
  chars = name.chars
  chars.map do |char|
    startord = char.ord
    replaceord = char.ord - 13
    if startord == 32
      startord.chr
    elsif replaceord < 65
      (replaceord + 26).chr
    elsif replaceord < 97 && startord >= 97
      (replaceord + 26).chr
    else
      replaceord.chr
    end
  end.join('')
end

p rot131('HELLO')

names.each { |x| p rot131(x)}

# Or

def rot13(encrypted_text)
  encrypted_text.each_char.reduce('') do |result, encrypted_char|
    result + decipher_character(encrypted_char)
  end
end

def decipher_character(encrypted_char)
  case encrypted_char
  when 'a'..'m', 'A'..'M' then (encrypted_char.ord + 13).chr
  when 'n'..'z', 'N'..'Z' then (encrypted_char.ord - 13).chr
  else                         encrypted_char
  end
end

names.each do |name|
  puts rot13(name)
end

# 6) Iterators: True for Any?

def any?(arr)
  arr.each { |x| return true if yield(x) }
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false

# 7) Iterators: True for All?

def all?(arr)
  arr.each {|x| return false unless yield(x)}
  true
end

p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true

# 8) Iterators: True for None?

def none?(arr)
  arr.each {|x| return false if yield(x)}
  true
end

# Alternatively, we can use our previsouly defined `all?` method and return the opposite.

def none?(collection, &block)
  !any?(collection, &block) # explicitly passing the block to the `any?` method.
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true

# 9) Iterators: True for One?

def one?(arr)
  count = 0
  arr.each do |x| 
    count += 1 if yield(x)
    return false if count > 1
  end
  count == 0 ? false : true
end

# or

def one?(collection)
  seen_one = false
  collection.each do |element|
    next unless yield(element)
    return false if seen_one
    seen_one = true
  end
  seen_one
end

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }                     # -> false

# 10) Count Items

def count(arr)
  count = 0
  arr.each {|x| count += 1 if yield(x)}
  count
end

# FE, find a solution without using each, loop, while, or until.

def count(arr)
  total = 0
  0.upto(arr.size - 1) do |index|
    total += 1 if yield(arr[index])
  end
  total
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2

=end
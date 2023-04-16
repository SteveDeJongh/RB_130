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

=end

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

def rot13(name)
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

p rot13('HELLO')

names.each { |x| p rot13(x)}
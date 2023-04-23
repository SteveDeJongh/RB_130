##### RB 130 Challenges Perfect Number #####

=begin
  
Problem
A perfect number has an aliquot sum (sum of all positive divisors) equal to the original number
Abundand numbers have an aliquot sum that is greater than the original number
Deificient numbers have an aliquot sum that i less than the original number


=end

class PerfectNumber
  attr_reader :number

  def initialize(number)
    raise StandardError if number < 0
    @number = number
  end

  def self.classify(num)
    check = PerfectNumber.new(num)

    checknum = check.number

    aliquot = check.even_divisors

    self.determine(aliquot, checknum)
  end

  def even_divisors
    num = self.number

    divisors = 0
    1.upto(num - 1) do |x|
      if (num % x) == 0
        divisors += x
      end
    end
    divisors
  end

  def self.determine(aliquot, start_num)
    case
    when aliquot == start_num then 'perfect'
    when aliquot > start_num  then 'abundant'
    when aliquot < start_num  then 'deficient'
    end
  end
end
##### RB 130 Challenges Custom Set #####

=begin
Start: 1:12
end: 1:44
Total: 32 mins
Passes all tests, passed rubocop

Problem:
Implement a custom set class
All elements of a set must be numbers

Class CustomSet
constructor, accepts array as argument
empty? checks if set is empty
contains? checks if set has passed in element
subset? checks if called on set object is included in passed in argument
 set object
disjoint? checks that none of the sets elements match passed in sets
 elements
eql? checks if each set element is included in the other set
add(el), adds element to set
intersection, creates new set object containing elements contained in
 both passed in set.
difference, returns calling set with all elements removed that are not
 in passed in set
union, returns calling set with all elements added that don't already
 exist from passed in set

=end

class CustomSet
  attr_reader :set

  def initialize(arr = [])
    @set = arr
  end

  def empty?
    set.empty?
  end

  def contains?(el)
    @set.any? { |x| x == el }
  end

  def subset?(otherset)
    @set.all? { |x| otherset.set.include?(x) }
  end

  def disjoint?(otherset)
    set.none? { |x| otherset.set.include?(x) }
  end

  def eql?(otherset)
    return false if set.empty? && !otherset.set.empty?
    subset?(otherset)
  end

  alias == eql?

  def add(el)
    set << el unless set.include?(el)
    self
  end

  def intersection(otherset)
    result = set.select { |x| otherset.set.include?(x) }
    CustomSet.new(result)
  end

  def difference(otherset)
    result = set.select { |x| otherset.set.none?(x) }
    CustomSet.new(result)
  end

  def union(otherset)
    result = []
    set.each { |x| result << x unless result.include?(x) }
    otherset.set.each { |x| result << x unless result.include?(x) }
    CustomSet.new(result)
  end
end

set1 = CustomSet.new([1])
set1.add(2)
p set1
p set1.empty?

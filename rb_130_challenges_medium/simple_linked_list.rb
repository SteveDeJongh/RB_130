##### Rb 130 Challenges Simple linked list #####

=begin

Start: 0:49
End: 1:37
Total: 48 minutes, passes all tests and rubocop.

# Problem:

Class: Element
constructor: arg1 number (data), arg2 optional, indicates previous
  element in list.
datum
tail?
next: returns next element in list

Class: SimpleLinkedList
size: returns number of elements in list
empty?: returns ture or false
push(arg1): creates and adds element to list
peek: returns datum of last element
head: returns object of first element in list
pop: removes and returns last element of list
from_a; ?
=end

class Element
  def initialize(data, linked = nil)
    @data = data
    @nextup = linked
  end

  def datum
    @data
  end

  def tail?
    @nextup.nil?
  end

  def next
    @nextup
  end
end

class SimpleLinkedList
  def initialize
    @list = []
  end

  def size
    @list.size
  end

  def empty?
    @list.empty?
  end

  def push(data)
    @list << if size < 1
               Element.new(data)
             else
               Element.new(data, @list.last)
             end
  end

  def peek
    @list.empty? == false ? @list.last.datum : nil
  end

  def head
    @list.last
  end

  def pop
    @list.pop.datum
  end

  def to_a
    @list.map(&:datum).reverse
  end

  def self.from_a(arr)
    temp = SimpleLinkedList.new
    return temp if arr.nil?
    arr.reverse.each do |x|
      temp.push(x)
    end
    temp
  end

  def reverse
    SimpleLinkedList.from_a(to_a.reverse)
  end
end

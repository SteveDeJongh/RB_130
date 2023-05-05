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

=begin

class Element
  attr_reader :next, :datum

  def initialize(data, linked = nil)
    @datum = data
    @next = linked
  end

  def tail?
    @next.nil?
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

  def to_s
    @list.each do |x|
      p x
    end
  end
end

# list = SimpleLinkedList.from_a([1,2,3,4,5])

# puts list

=end

# LS Solution, similar, but @head only tracks the current last element,
# rather than have all elements in an array.

class Element
  attr_reader :datum, :next

  def initialize(datum, next_element = nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def size
    size = 0
    current_elem = @head
    while current_elem
      size += 1
      current_elem = current_elem.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def push(datum)
    element = Element.new(datum, @head)
    @head = element
  end

  def peek
    @head ? @head.datum : nil
  end

  def pop
    datum = peek
    new_head = @head.next
    @head = new_head
    datum
  end

  def self.from_a(array)
    array = [] if array.nil?

    list = SimpleLinkedList.new
    array.reverse_each { |datum| list.push(datum) }
    list
  end

  def to_a
    array = []
    current_elem = head
    while !current_elem.nil?
      array.push(current_elem.datum)
      current_elem = current_elem.next
    end
    array
  end

  def reverse
    list = SimpleLinkedList.new
    current_elem = head
    while !current_elem.nil?
      list.push(current_elem.datum)
      current_elem = current_elem.next
    end
    list
  end
end

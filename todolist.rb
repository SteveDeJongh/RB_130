##### Lesson 1: TodoList #####

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    if item.class == Todo
      todos << item
    else
      raise TypeError.new("Can only add Todo objects")
    end

    # Or
    # raise TypeError, "can only add Todo objects" unless item.instance_of? Todo

    # todos << item
  end

  alias << add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def done?
    todos.all? {|item| item.done?}
  end

  def item_at(pos)
    if pos <= todos.size
      todos[pos]
    else
      raise IndexError
    end

    # Or using `array#fetch` to raise error
    # todos.fetch(pos)
  end

  def mark_done_at(pos)
    if pos <= todos.size
      todos[pos].done!
    else
      raise IndexError
    end

    # or using `TodoList#item_at` to raise error
    # item_at(pos).done!
  end

  def mark_undone_at(pos)
    if pos <= todos.size
      todos[pos].undone!
    else
      raise IndexError
    end

    # Or using `TodoList#item_at`
  end

  def done!
    todos.each {|item| item.done! }

    # Or using `TodoList#mark_done_at`
    # todos.each_with_index { |idx| mark_done_at(idx)}
  end

  def remove_at(pos)
    if pos <= todos.size
      todos.delete_at(pos)
    else
      raise IndexError
    end
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    todos
  end

  def each
    todos.each do |todo|
      yield(todo)
    end

    self # Added `self` to return the original object from the `TodoList#each` method.

    # Without using `Array#each`
    # counter = 0

    # while counter < todos.size
    #   yield(item_at(counter))
    #   counter += 1
    # end

    # todos
  end

  # def select # Select method but returning an array object.
  #   result = []
  #   each do |item| # Calling `todolist#each`
  #     result << item if yield(item)
  #   end

  #   result
  # end

  def select # `TodoList#select` method but returning a `TodoList` object.
    list = TodoList.new(title)
    each do |item| # Calling `todolist#each`
      list << item if yield(item)
    end

    list
  end

  def find_by_title(name)
    # result = TodoList.new('temp')
    
    # each {|item| result << item if item.title == name} 

    # result.size > 0 ? result.first : nil
    # or
    select {|todo| todo.title == name }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(name)
    each {|todo| todo.done! if todo.title == name }

    self

    # or

    # find_by_title(name) && find_by_title(name).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
  
  private

  attr_accessor :todos
end
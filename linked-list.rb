class LinkedList

  def initialize value = nil
    node = Node.new value
    @head = node
    @tail = node
  end

  def append value
    new_node = Node.new value
    @tail.next = new_node
    @tail = new_node
  end

  def prepend value
    new_node = Node.new value, @head
    @head = new_node
  end

  def size
    return (@head.value == nil) ? 0 : (@head.next == nil) ? 1 : _size(@head)
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def at index
    if index >= self.size
      return "Index out of bounds"
    end    
    current_node = @head
    index.times do
      current_node = current_node.next
    end
    current_node
  end

  def pop
    index = self.size - 2
    @tail = self.at index
    @tail.next = nil
  end

  def contains? value
    return _contains? value, @head
  end

  def find value
    if !self.contains?(value)
      return "No such entry in the lise"
    end
    index = 0
    current_node = @head
    while current_node.next != nil
      break if current_node.value == value
      current_node = current_node.next
      index += 1
    end
    index
  end

  def to_s
    if self.size == 0
      return "nil"
    end
    output = ""
    current_node = @head
    loop do
      output += "( #{current_node.value} ) -> "
      (current_node.next == nil) ? break : current_node = current_node.next
    end
    return output += "nil"
  end

  def insert_at value, index
    prev_node = self.at index - 1
    next_node = prev_node.next
    new_node = Node.new value
    prev_node.next = new_node
    new_node.next = next_node
  end

  def remove_at index
    prev_node = self.at index -1
    next_node = self.at index + 1
    prev_node.next = next_node
  end

  private

  def _size current_node
    if current_node.next == nil
      return 1
    end
    current_node = current_node.next
    return _size(current_node) + 1
  end

  def _contains? value, current_node
    if current_node.value == value
      return true
    elsif current_node.next == nil
      return false
    else
      current_node = current_node.next
      _contains? value, current_node
    end
  end
end

class Node
  attr_accessor :value, :next
  def initialize value = nil, next_node = nil
    @value = value
    @next = next_node
  end
end

# tests
# -------------------------------------
# initialize
list = LinkedList.new(1)
p list.head.value
p list.head.next
p list.tail.value
# -------------------------------------
# append
p "APPEND"
list.append 2
p list.head.value
p list.head.next
p list.tail.value
# -------------------------------------
# prepend
p "PREPEND"
list.prepend 0
p list.head.value
p list.head.next
p list.tail.value
# -------------------------------------
# size
p "SIZE"
p list.size
empty_list = LinkedList.new
p empty_list.size
one_el_list = LinkedList.new 4
p one_el_list.size
# -------------------------------------
# at
p "AT"
p list.at(0)
p list.at(1)
p list.at(8)
# -------------------------------------
# pop
p "POP"
p list.tail
list.pop
p list.tail
p list.head
# -------------------------------------
# cotains?
p "CONTAINS?"
p list.contains?(1)
another_list = LinkedList.new 1
another_list.append 2
another_list.append 3
p another_list.contains? 2
p list.contains?(9)
# -------------------------------------
# find
p "FIND"
p list.find(1)
p list.find(0)
p list.find(15)
# -------------------------------------
# to_s
p "TO_S"
p list.to_s
p empty_list.to_s
# -------------------------------------
# insert_at
p "INSERT_AT"
list.insert_at 5, 1
p list.to_s
# -------------------------------------
# remove_at
p "REMOVE_AT"
list.remove_at 1
p list.to_s
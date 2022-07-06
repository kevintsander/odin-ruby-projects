#frozen_string_literal: true

require_relative 'node'

# Represents a linked list
class LinkedList
  attr_accessor :name
  attr_reader :head, :tail
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    @head ||= new_node
    if @tail
      @tail.next_node = new_node
    end
    @tail = new_node
    self
  end

  def prepend(value)
    new_node = Node.new(value)
    @tail ||= new_node
    if @head
      new_node.next_node = @head
    end
    @head = new_node
    self
  end

  def size
    size = 0
    node = @head
    until node.nil?
      size += 1
      node = node.next_node
    end
    size
  end

  def at(index)
    count = 0
    node = @head
    until count == index || node.nil?
      count += 1
      node = node.next_node
    end
    node
  end

  def pop
    return nil if @head.nil? || @tail.nil?

    last_node = @tail
    node = @head
    node = node.next_node until node.next_node == @tail
    node.next_node = nil
    @tail = node
    last_node
  end

  def to_s
    node = @head
    s = ''
    until node.nil?
      s += "( #{node.value} )"
      s += ' -> '
      node = node.next_node
    end
    s += 'nil'
  end

  def find(value)
    node = @head
    count = 0
    until node.nil? || node.value == value
      count += 1
      node = node.next_node
    end
    node.nil? ? nil : count
  end

  def contains?(value)
    return find(value) ? true : false
  end

  def insert_at(index, value)
    if index == 0
      prepend(value)
      return self
    end
    
    new_node = Node.new(value)
    node = @head
    count = 0
    until node.nil? || count == index - 1
      node = node.next_node
      count += 1
    end
    unless node.nil?
      new_node.next_node = node.next_node
      node.next_node = new_node
    end
    self
  end

  def remove_at(index)
    node = @head
    count = 0
    until node.nil? || count == index - 1
      node = node.next_node
      count += 1
    end
    node.next_node = node.next_node&.next_node unless node.nil?
    self
  end

        

end
# frozen_string_literal: true

require_relative 'node'

# linked list class
class LinkedList
  attr_accessor :head

  def initialize(value = nil)
    @head = Node.new(value)
  end

  def each_node
    ptr = @head
    until ptr.nil?
      yield(ptr)
      ptr = ptr.next_node
    end
  end

  def tail
    each_node { |node| return node if node.next_node.nil? }
  end

  def append(value)
    tail.next_node = Node.new(value)
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    count = 0
    each_node { count += 1 }
    count
  end

  def at(index)
    i = 0
    each_node do |node|
      return node if i == index
      i += 1
    end
  end

  def pop
    each_node { |node| node.next_node = nil if node.next_node.next_node.nil? }
  end

  def contains?(value)
    each_node { |node| return true if node.value == value }
    false
  end

  def find(value)
    index = 0
    each_node do |node|
      return index if node.value == value
      index += 1
    end
  end

  def to_s
    each_node do |node|
      if node.next_node.nil?
        puts "#{node.value} -> nil"
      else
        print "#{node.value} -> "
      end
    end
  end

  def insert_at(value, index)
    i = 0
    each_node do |node|
      if i == index - 1
        new_node = Node.new(value, node.next_node)
        node.next_node = new_node
      end
      i += 1
    end
  end

  def remove_at(index)
    i = 0
    each_node do |node|
      node.next_node = node.next_node.next_node if i == index - 1 
      i += 1
    end
  end
end

# frozen_string_literal: true
require_relative "node"

# Represents a binary search tree
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def find(value, root = @root)
    case
    when root.nil? || root.data == value
      return root
    when root.data > value
      return find(value, root.left)
    when root.data < value
      return find(value, root.right)
    end
  end

  def insert(value, root = @root)
    case
    when root.nil?
      root = Node.new(value)
    when root.data > value
      root.left = insert(value, root.left)
    when root.data < value
      root.right = insert(value, root.right)
    end
    root
  end

  def delete(value, root = @root)
    case
    when root.nil?
      return
    when root.data > value
      root.left = delete(value, root.left)
    when root.data < value
      root.right = delete(value, root.right)
    else
      if root.left.nil?
        return root.right 
      elsif root.right.nil?
        return root.left
      end
      
      # node has two children
      # set the root to the smallest value in the right tree (inorder successor)
      root.data = min_value(root.right)
      # delete the original successor node
      root.right = delete(value, root.right)
    end
    root 
  end

  def level_order_iterate
    queue = []
    queue << @root
    until queue.empty?
      node = queue.shift
      yield node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end
  end

  def level_order_recursive(node = @root, queue = [], &block)
    yield node.data
    queue << node.left if node.left
    queue << node.right if node.right
    return if queue.empty?

    level_order_recursive(queue.shift, queue, &block)
  end

  def inorder(node = @root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    yield node if block_given?
    result << node.data
    inorder(node.right, result, &block)
    result
  end

  def preorder(node = @root, result = [], &block)
    return if node.nil?

    yield node if block_given?
    result << node.data
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result
  end

  def postorder(node = @root, result = [], &block)
    return if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    yield node.data if block_given?
    result << node.data
    result
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  # Builds a balanced binary search tree
  def build_tree(arr)
    return if arr.size == 0

    mid = arr.size / 2
    node = Node.new(arr[mid])

    node.left = build_tree(arr[0...mid])
    node.right = build_tree(arr[(mid + 1)..-1])

    node
  end

  def min_value(root)
    min = root.data
    until root.left.nil?
      min = root.left.data
      root = root.left
    end
    min
  end
end

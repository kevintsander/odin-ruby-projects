# frozen_string_literal: true

# Represents a tree node
class Node
  attr_accessor :left, :right, :data
  def initialize(data)
    @data = data 
    @left = nil
    @right = nil
  end
end
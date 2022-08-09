# frozen_string_literal: true

# Represents a player for the game
class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end

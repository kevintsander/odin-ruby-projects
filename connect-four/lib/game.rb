# frozen_string_literal: true

# Represents a Connect Four game
class Game
  attr_reader :board

  class OutOfBoundsInputError < StandardError; end

  def initialize(board)
    @board = board
  end

  def get_column_input(player)
    input = nil
    until input
      puts "#{player.name}, which column do you want to play? (0-#{board.columns - 1})"
      begin
        input = validate_column_input(gets.chomp)
      rescue OutOfBoundsInputError
        puts "Out of bounds, must be between 0 and #{board.columns - 1}"
      rescue ArgumentError
        puts "Invalid entry, must be a number between 0 and #{board.columns - 1}"
      end
    end
    input
  end

  def validate_column_input(input)
    column = begin
      Integer(input)
    rescue StandardError
      nil
    end
    raise ArgumentError unless column
    raise OutOfBoundsInputError unless column.between?(0, board.columns - 1)

    column
  end
end

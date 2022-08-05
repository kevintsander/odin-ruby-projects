# frozen_string_literal: true

# Represents a game board
class Board
  attr_reader :rows, :columns, :win_count, :matrix

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @colums = columns
    @win_count = win_count
    @matrix = Array.new(rows) { Array.new(columns) }
  end

  def add_piece(piece, column)
    add_row = get_open_row(column)
    @matrix[add_row][column] = piece
  end

  private

  def get_open_row(column)
    row = 0
    row += 1 while @matrix[row][column] && row < rows
    row
  end
end

# frozen_string_literal: true

# Represents a game board
class Board
  attr_reader :rows, :columns, :win_count, :matrix

  DIRECTIONS = [[-1,  1], [0,  1], [1,  1],
                [-1,  0],          [1,  0],
                [-1, -1], [0, -1], [1, -1]].freeze

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @win_count = win_count
    @matrix = Array.new(rows) { Array.new(columns) }
  end

  # Adds a piece to the next available row for the specified column
  def add_piece(piece, column)
    add_row = get_open_row(column)
    @matrix[add_row][column] = piece
  end

  # Tests if there are four of the same piece in a row
  def four_in_a_row?
    rows.times do |row_index|
      columns.times do |col_index|
        return true if four_in_a_row_starting_from?(row_index, col_index)
      end
    end
    false
  end

  def full?
    matrix.flatten.none?(&:nil?)
  end

  def display
    display_header
    display_grid
    display_footer
  end

  private

  # Tests if there is four in a row starting from a specified location
  def four_in_a_row_starting_from?(row, col)
    DIRECTIONS.each do |dir|
      return true if four_in_a_row_direction?(row, col, dir)
    end
    false
  end

  # Tests if there is four in a row in a direction from the specified locaiton
  def four_in_a_row_direction?(row, col, direction)
    start_piece = nil
    4.times do
      piece = matrix[row][col]
      start_piece ||= piece
      col += direction[0]
      row += direction[1]
      return false unless start_piece && start_piece == piece
    end
    true
  end

  # Gets the next row without a piece for the specified column
  def get_open_row(column)
    row = 0
    row += 1 while @matrix[row][column] && row < rows
    row
  end

  def display_grid
    # want to reverse grid display
    (rows - 1).downto(0) { |row| puts row_text(row) }
  end

  def row_text(row)
    text = ''
    columns.times do |col|
      text += cell_text(row, col)
    end
    text
  end

  def cell_text(row, col)
    pretext = col.zero? ? '|' : ''
    piece = matrix[row][col]
    piecetext = piece || '  '
    posttext = col == columns - 1 ? '|' : ''
    pretext + piecetext + posttext
  end

  def display_header
    puts columns.times do |index|
      " #{index}"
    end
  end

  def display_footer
    puts '‾' * 2 * columns
  end
end

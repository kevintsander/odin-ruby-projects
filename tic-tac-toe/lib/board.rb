class TicTacToeBoard
  def initialize
    @board = Array.new(3) { Array.new(3) }
  end

  def won_row?
    @board.any? do |row|
      row.uniq.count == 1 && row.none?(&:nil?)
    end
  end

  def won_column?
    @board.transpose.any? do |col|
      col.uniq.count == 1 && col.none?(&:nil?)
    end
  end

  def won_diagonal?
    i = 0
    left_diag = []
    right_diag = []
    size = @board.size
    while i < size
      left_diag.push(@board[i][i])
      right_diag.push(@board[size - i - 1][size - i - 1])
      i += 1
    end
    (left_diag.uniq.count == 1 && left_diag.none?(&:nil?)) ||
      (right_diag.uniq.count == 1 && right_diag.none?(&:nil?))
  end

  def location_open?(row, column)
    @board[row][column].nil? ? true : false
  end

  def update_board(player, row, column)
    @board[row][column] = player
    display_board
  end

  def display_board
    text = ''
    @board.each_with_index do |row, row_i|
      rowtext = ''
      row.each_with_index do |item, col_i|
        rowtext += item.nil? ? '   ' : " #{item} "
        col_i != row.size - 1 && rowtext += '|'
      end
      text += rowtext
      row_i != @board.size - 1 && text += "\n---+---+---\n"
    end

    puts text
  end

  def won?
    won_row? || won_column? || won_diagonal?
  end
end

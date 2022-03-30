# Represents a tic-tac-toe game
class TicTacToeGame
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = Array.new(3) { Array.new(3) }
  end

  private

  def space_taken_message
    puts 'Space already taken! Select again.'
  end

  def win_message(player)
    puts "#{player} WON!!!"
  end

  def location_open?(row, column)
    @board[row][column] == nil ? true : false
  end

  def won_row?
    return @board.any? do |row|
      row.uniq.count == 1 && row.none?(&:nil?)
    end
  end

  def won_column?
    return @board.transpose.any? do |col|
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
      right_diag.push(@board[size - i  - 1][size - i - 1])
      i += 1
    end
    return (left_diag.uniq.count == 1 && left_diag.none?(&:nil?)) ||
           (right_diag.uniq.count == 1 && right_diag.none?(&:nil?))
  end

  def won?
    won_row? || won_column? || won_diagonal?
  end

  public

  def play_turn(player)
    puts "#{player}, enter row #, then column #:"
    position_open = false
    row = nil
    column = nil
    while position_open == false
      puts "Row:"
      row = gets.chomp.to_i - 1
      puts "Column:"
      column = gets.chomp.to_i - 1
      position_open = location_open?(row, column)
      if position_open == false
        space_taken_message
      end
    end
    update_board(player, row, column)
  end


  def play_game
    while !won?
      play_turn(@player1)
      if won?
        return win_message(@player1)
      end
      play_turn(@player2)
      if won?
        return win_message(@player2)
      end
    end
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
        puts "item: #{item}"
        rowtext += item.nil? ? '   ' : " #{item} "
        puts "col_i: #{col_i} row size: #{row.size}"
        col_i != row.size - 1 && rowtext += '|'
      end
      text += rowtext
      row_i != @board.size - 1 && text += "\n---+---+---\n"
    end

    puts text
  end
end

game = TicTacToeGame.new('O', 'X')
game.play_game
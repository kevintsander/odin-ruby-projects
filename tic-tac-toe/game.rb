# Represents a tic-tac-toe game
class TicTacToeGame
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = Array.new(3) { Array.new(3) }
    p @board
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

  def win?
    win = false
    win = @board.any? do |row|
      row.uniq.count == 1 && row.none?(&:nil?)
    end
    if win == true
      return true
    end

    #transpose and check columns
    win = @board.transpose.any? do |col|
      col.uniq.count == 1 && col.none?(&:nil?)
    end
    if win == true
      return true
    end

    #check diagonals
    left_i = 0
    left_diag = []
    while left_i < @board.size
      left_diag.push(@board[left_i][left_i])
      left_i += 1
    end
    win = left_diag.uniq.count == 1 && left_diag.none?(&:nil?)
    if win == true
      return true
    end

    right_i = @board.size - 1
    right_diag = []
    while right_i >= 0
      right_diag.push(@board[right_i][right_i])
      right_i -= 1
    end
    win = right_diag.uniq.count == 1 && right_diag.none?(&:nil?)
    if win == true
      return true
    end

    false
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
    while !win?
      play_turn(@player1)
      if win?
        return win_message(@player1)
      end
      play_turn(@player2)
      if win?
        return win_message(@player2)
      end
    end
  end

  def update_board(player, row, column)
    @board[row][column] = player
    display_board
  end
end

game = TicTacToeGame.new('O', 'X')
game.play_game
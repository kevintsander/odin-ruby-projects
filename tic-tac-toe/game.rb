# frozen_string_literal: true

require_relative 'board.rb'

# Represents a tic-tac-toe game
class TicTacToeGame

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = TicTacToeBoard.new
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
      position_open = @board.location_open?(row, column)
      if position_open == false
        space_taken_message
      end
    end
    @board.update_board(player, row, column)
  end


  def play_game
    while !@board.won?
      play_turn(@player1)
      if @board.won?
        return win_message(@player1)
      end
      play_turn(@player2)
      if @board.won?
        return win_message(@player2)
      end
    end
  end

  def update_board(player, row, column)
    @board.board[row][column] = player
    display_board
  end

  
end

game = TicTacToeGame.new('O', 'X')
game.play_game
# frozen_string_literal: true

require_relative 'board'

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

  public

  def play_turn(player)
    puts "#{player}, enter row #, then column #:"
    position_open = false
    row = nil
    column = nil
    while position_open == false
      puts 'Row:'
      row = gets.chomp.to_i - 1
      puts 'Column:'
      column = gets.chomp.to_i - 1
      position_open = @board.location_open?(row, column)
      space_taken_message if position_open == false
    end
    @board.update_board(player, row, column)
  end

  def play_game
    until @board.won?
      play_turn(@player1)
      return win_message(@player1) if @board.won?

      play_turn(@player2)
      return win_message(@player2) if @board.won?
    end
  end

  def update_board(player, row, column)
    @board.board[row][column] = player
    display_board
  end
end

game = TicTacToeGame.new('O', 'X')
game.play_game

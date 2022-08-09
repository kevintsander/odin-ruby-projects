# frozen_string_literal: true

require './lib/player'

# Represents a Connect Four game
class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(board)
    @board = board
  end

  def setup_players
    @player1 = setup_player(1)
    @player2 = setup_player(2)
  end

  def setup_player(player_id)
    name = get_player_name(player_id)
    piece = get_player_game_piece(name)
    Player.new(name, piece)
  end

  def play_turn
    board.add_piece(@current_player.piece)
    @current_player = get_next_player
  end

  def get_column_input(player)
    input = nil
    until input
      puts "#{player.name}, which column do you want to play? (0-#{board.columns - 1})"
      begin
        input = validate_column_input(gets.chomp)
      rescue RangeError
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
    raise ArgumentError, 'input must be a number' unless column
    raise RangeError, 'number must be within range' unless column.between?(0, board.columns - 1)

    column
  end

  def get_player_name(player_id)
    puts "What is player #{player_id}'s name?"
    gets.chomp[0..50].capitalize
  end

  def get_player_game_piece(player_name)
    piece = nil
    until piece
      puts "What game piece do you want to use, #{player_name}? (0 = ⚫ 1 = ⚪)"
      piece = begin
        validate_game_piece(gets.chomp)
      rescue ArgumentError
        puts 'Game piece not valid, enter a valid piece.'
      end
    end
    piece
  end

  def validate_game_piece(input)
    raise ArgumentError, 'Game piece already taken.' if game_piece_taken(input)

    input = '⚫' if %w[1 b black].include?(input)
    input = '⚪' if %w[2 w white].include?(input)
    return input.downcase if input.size == 1 && input.match(/\S/)

    raise ArgumentError, 'Game piece must be one non-space character long.'
  end

  private

  def game_piece_taken(input)
    [player1.piece, player2.piece].include?(input)
  end

  def get_next_player
    @current_player = @player1 ? @player2 : @player1
  end
end

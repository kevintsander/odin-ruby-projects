# frozen_string_literal: true

require './lib/player'
require 'io/console'

# Represents a Connect Four game
class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(board)
    @board = board
  end

  def setup_players
    @player1 = nil
    @player2 = nil
    @player1 = setup_player(1)
    @player2 = setup_player(2)
  end

  def setup_player(player_id)
    name = get_player_name(player_id)
    piece = player_id == 1 ? get_player_game_piece(name) : get_other_game_piece(name)
    Player.new(name, piece)
  end

  def play
    display_intro
    setup_players
    display_game
  end

  def display_game
    @current_player = player1
    board.display
    loop do
      this_player = @current_player
      display_turn
      if board.four_in_a_row?
        winner(this_player)
        break
      elsif board.full?
        draw
        break
      end
    end
  end

  def draw
    puts 'Board is full! Game is a draw.'
  end

  def winner(player)
    puts "CONNECT FOUR! #{player.name} wins!!!"
  end

  def display_turn
    play_turn
    $stdout.clear_screen
    board.display
  end

  def play_turn
    board.add_piece(@current_player.piece, get_column_input(@current_player))
    @current_player = get_next_player
  end

  def get_column_input(player)
    input = nil
    until input
      puts "#{player.name}, which column do you want to play? (0-#{board.columns - 1})"
      begin
        input = validate_column_input(gets.chomp)
      rescue RangeError
        puts "Out of bounds, must select non-full row between 0 and #{board.columns - 1}"
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
    raise RangeError, 'row is full' if board.column_full?(column)

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

  def get_other_game_piece(player_name)
    return unless player1

    piece = case player1.piece
            when '⚫'
              '⚪'
            when '⚪'
              '⚫'
            end
    puts "#{player_name} will be #{piece}."
    piece
  end

  def validate_game_piece(input)
    valid_input = '⚫' if %w[0 b black ⚫].include?(input)
    valid_input = '⚪' if %w[1 w white ⚪].include?(input)

    raise ArgumentError, 'Must enter 0 or 1!' unless valid_input

    valid_input
  end

  private

  def get_next_player
    @current_player = @player1 == @current_player ? @player2 : @player1
  end

  def display_intro
    puts <<~INTRO
      Welcome to CONNECT FOUR!#{' '}
      The rules are simple:
      - Players take turns placing tokens in the slots
      - First player to get four-in a row horizontally, vertically, or diagonally wins!
      - If no players get four in a row before the board fills up, its a draw.
    INTRO
  end
end

# frozen_string_literal: true

require 'pry-byebug'
require 'highline/import'
require_relative 'code_score'
require_relative 'scoreboard'
require_relative 'player'
require_relative 'knuth_ai'

# Represents a game of Mastermind
class Game
  attr_reader :players

  def initialize
    @players = []
    @scoreboard = ScoreBoard.new
    @code = nil
    @turns = 12
    @current_turn = 0
    @code_master = nil
    @code_breaker = nil

    @code_length = 4
    @code_options = 6
  end

  def play
    show_intro
    startup
    keep_playing = true
    while keep_playing == true
      @scoreboard.refresh
      setup_code_master
      refresh_ai
      get_code
      @turns.times do |current_turn|
        @current_turn = current_turn
        turn
        puts @scoreboard.last_code_score_text
        if win?
          puts win_text
          break
        elsif current_turn == @turns - 1
          puts lose_text
        end
      end
      !replay? && keep_playing = false
    end
  end

  private

  def startup
    puts 'Ready to start? Press any key (or "o" for options).'
    start_key = STDIN.getch
    start_key.downcase == 'o' && setup_options
    setup_players
  end

  def setup_options
    setup_turns
  end

  def setup_players
    setup_humans
    fill_cpus
  end

  def setup_turns
    setup = false
    until setup == true
      puts 'How many turns allowed to guess code? (5-20)'
      turns = gets.chomp
      unless Integer(turns, exception: false) && [*5..20].include?(turns = turns.to_i)
        puts 'Invalid number entered.'
        redo
      end
      @turns = turns.to_i
      setup = true
    end
  end

  def setup_humans
    setup = false
    until setup == true
      puts 'How many human players are there? (0-2)'
      humans = gets.chomp
      unless Integer(humans, exception: false) && [*0..2].include?(humans = humans.to_i)
        puts 'Invalid number entered.'
        next
      end
      humans.times do |index|
        puts "Player #{index + 1} name:"
        name = gets.chomp
        @players.push(HumanPlayer.new(name))
      end
      setup = true
    end
  end

  def refresh_ai
    @players.select { |player| player.is_a?(ComputerPlayer) }.each(&:refresh_ai)
  end

  def fill_cpus
    cpus = 2 - @players.count
    cpus.times do
      ai = KnuthAI.new(@code_length, @code_options, @scoreboard)
      @players.push(ComputerPlayer.new(nil, ai))
    end
  end

  def setup_code_master
    setup = false
    until setup == true
      puts 'Who will be the code master? (other player will be code breaker)'
      puts "1 = #{player_text(@players[0])} 2 = #{player_text(@players[1])} 3 = Random"
      master = gets.chomp
      unless Integer(master, exception: false) && [*1..3].include?(master = master.to_i)
        puts 'Invalid number entered.'
        next
      end

      random = false
      if master == 3
        random = true
        master = [1, 2].sample
      end
      master -= 1 # align with indeces
      breaker = master.zero? ? 1 : 0
      @code_master = @players[master]
      @code_breaker = @players[breaker]
      puts "Randomly selected #{@code_master.name} as the code master." if random == true
      setup = true
    end
  end

  def get_code
    puts "#{@code_master.name}, enter the secret code:"
    @code = GameCode.new(@code_master.create_code)
  end

  def turn
    puts "#{@code_breaker.name}, try to guess to code:"
    guess = GameCode.new(@code_breaker.guess)
    score = CodeScore.new.calculate(@code, guess)
    @scoreboard.add(guess, score)
  end

  def win?
    @scoreboard.last_score.full == @code_length
  end

  def replay?
    setup = false
    do_replay = false
    while setup == false
      puts 'Would you like to play again? (Y/N)'
      replay = gets.chomp.downcase
      case replay
      when 'y'
        do_replay = true
      when 'n'
        do_replay = false
      else
        puts 'Invalid value.'
        next
      end
      setup = true
    end
    do_replay
  end

  def player_text(player)
    player.name + (player.is_a?(ComputerPlayer) ? '(CPU)' : '')
  end

  def win_text
    "#{@code_breaker.name} broke #{@code_master.name}'s code!"
  end

  def lose_text
    "Code not broken. #{@code_master.name} stumped #{@code_breaker.name}! The code was #{@code.text}"
  end

  def show_intro
    puts 'Welcome to Mastermind! One player will create a code and the other will try' \
         'to guess it before running out of turns.'
  end
end

# frozen_string_literal: true

class GameDisplay
  def initialize(game)
    @game = game
  end

  def result
    correct
    hangman
    all if @game.guesses.count > 0
    if @game.status == :win
      win
    elsif @game.status == :loss
      loss
    end
  end

  def hangman
    puts case @game.incorrect_guesses.count
    when 0
      "____ \n"\
      "|  | \n"\
      "|    \n"\
      "|    \n"\
      "|    \n"\
      "‾‾‾‾‾"
    when 1
      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "|    \n"\
      "|    \n"\
      "‾‾‾‾‾"
    when 2
      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "|  | \n"\
      "|    \n"\
      "‾‾‾‾‾"
    when 3
      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "| /| \n"\
      "|    \n"\
      "‾‾‾‾‾"
    when 4
      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "| /|\\\n"\
      "|    \n"\
      "‾‾‾‾‾"
    when 5
      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "| /|\\\n"\
      "| /  \n"\
      "‾‾‾‾‾\n"
    when 6

      "____ \n"\
      "|  | \n"\
      "|  O \n"\
      "| /|\\\n"\
      "| / \\\n"\
      "‾‾‾‾‾\n"
    end
  end

  def already_guessed
    puts 'Letter already guessed!'
  end

  def not_a_letter
    puts 'Not a letter!'
  end

  def guess_prompt
    puts 'Guess a letter (or press 1 to save and exit):'
  end

  def save_prompt
    puts 'Would you like to save? (Y = yes)'
  end

  def save_name_prompt
    puts 'What do you want to name your save?'
  end

  def correct
    puts "Word: #{@game.correct_guesses_text}"
  end

  def all
    puts "Guesses: #{@game.all_guesses_text}"
  end

  def win
    puts "That's right, #{@game.word.upcase} is the word!"
  end

  def loss
    puts "Oops, you lost! #{@game.word.upcase} was the word!"
  end

end
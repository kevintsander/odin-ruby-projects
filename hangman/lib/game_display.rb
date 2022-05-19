# frozen_string_literal: true

class GameDisplay
  def initialize(game)
    @game = game
  end

  def result
    puts @game.word
    correct
    hangman
    all
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
    puts 'Guess a letter:'
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
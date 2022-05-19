# frozen_string_literal: true

class GameDisplay
  def initialize(game)
    @game = game
  end

  def result
    correct
    hangman
    all
    if game.status = :win
      win
    elsif game.status = :loss
      loss
    end
  end

  def hangman
    case game.incorrect_guesses
    when 0
      '____ '\
      '|  | '\
      '|    '\
      '|    '\
      '|    '\
      '‾‾‾‾‾'
    when 1
      '____ '\
      '|  | '\
      '|  O '\
      '|    '\
      '|    '\
      '‾‾‾‾‾'
    when 2
      '____ '\
      '|  | '\
      '|  O '\
      '|  | '\
      '|    '\
      '‾‾‾‾‾'
    when 3
      '____ '\
      '|  | '\
      '|  O '\
      '| /| '\
      '|    '\
      '‾‾‾‾‾'
    when 4
      '____ '\
      '|  | '\
      '|  O '\
      '| /|\\'\
      '|    '\
      '‾‾‾‾‾'
    when 5
      '____ '\
      '|  | '\
      '|  O '\
      '| /|\\'\
      '| /  '\
      '‾‾‾‾‾'
    when 6

      '____ '\
      '|  | '\
      '|  O '\
      '| /|\\'\
      '| / \\'\
      '‾‾‾‾‾'
  end

  def guess_prompt
    puts 'Guess a letter'
  end

  def correct
    puts @game.correct_guesses_text
  end

  def all
    puts @game.all_guesses_text
  end

  def win
    puts "That's right, #{@game.word} is the word!"
  end

  def loss
    puts "Oops, you lost! #{game.word} was the word!"
  end

end
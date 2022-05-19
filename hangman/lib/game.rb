# frozen_string_literal: true

class Game
  attr_reader guesses, word, number_of_turns

  def initialize(word_loader, number_of_turns = 6)
    @word = word_loader.word
    @number_of_turns = number_of_turns
    @guesses = []
  end

  def guess(letter)
    if valid_letter?(letter)
      if already_guessed?(letter)
        raise ArgumentError.new("Letter #{letter} already guessed")
      else
        @guesses.push({letter: letter.to_s, correct: letter_match?(letter)})
        set_status
      end
    else
      raise ArgumentError.new("Invalid entry, must be a single letter A-Z")
    end
  end

  def status
    if win?
      :win
    elsif loss?
      :loss
    else
      :playing
    end
  end

  def incorrect_guesses
    @guesses.sum { |guess| !guess[:correct] }
  end

  def already_guessed?(letter)
    @guesses.any? { |guess| guess[:letter] == letter }
  end

  def valid_letter?(letter)
    letter.respond_to?(:to_s) 
    && letter.size == 1
  end

  def win?
    correct = @guesses.select { |guess| guess[:correct] }
    word.all { |word_letter| correct[word_letter] }
  end

  def loss?
    incorrect_guesses >= number_of_turns
  end

  def letter_match?(letter)
    @word.include(letter)
  end

  def correct_guesses_text
    text = ''
    @word.each_with_index do |letter, index|
      if @guesses.key?(letter)
        text += '\e[4m' + letter + '\e[0m'
      else
        text += '_'
      end
    end
    text
  end

  def all_guesses_text
    text = ''
    @guesses.each_with_index do |guess, index|
      display_letter = guess[:letter]
      display_letter = '\e[4m' + display_letter + '\e[0m' if guess[:correct]
      text += index == 0 ? '' : ' '
      text += display_letter
    end
    text
  end

  def save

  end

  def load(id)

  end

end
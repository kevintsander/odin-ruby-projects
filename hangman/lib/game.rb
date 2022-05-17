# frozen_string_literal: true

class Game
  attr_reader guesses, word

  def initialize(word_loader, number_of_turns = 6)
    @word = word_loader.word
    @guesses = []
  end

  def guess(letter)
    if valid_letter?(letter)
      if already_guessed?(letter)

      else
        @guesses.push({letter: letter.to_s, correct: letter_match?(letter)})
      if win?

      elsif loss?

      end
    else

    end
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
    guesses.count >= number_of_turns
  end

  def letter_match?(letter)
    @word.include(letter)
  end

  def display_guesses
    display = ''
    @guesses.each_with_index do |guess, index|
      display_letter = guess[:letter]
      display_letter = '\e[4m' + display_letter + '\e[0m' if guess[:correct]
      display += index == 0 ? '' : ' '
      display += display_letter
    end
    puts display
  end

  def save

  end

  def load(id)

  end

end
# frozen_string_literal: true

require 'fileutils'
require 'yaml'
require_relative 'game_exceptions'

class Game
  attr_accessor :guesses, :word, :number_of_turns

  SAVE_DIR = File.expand_path('../saves/', __dir__)

  def initialize(word, number_of_turns = 6)
    @word = word
    @number_of_turns = number_of_turns
    @guesses = []
  end

  def guess(letter)
    if valid_letter?(letter)
      if already_guessed?(letter)
        raise LetterAlreadyGuessedError.new("Letter #{letter} already guessed")
      else
        @guesses.push(letter.upcase)
      end
    else
      raise NotALetterError.new("Invalid entry, must be a single letter A-Z")
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

  def correct_guesses
    @guesses.select { |guess| letter_match?(guess) }
  end

  def incorrect_guesses
    @guesses.reject { |guess| letter_match?(guess) }
  end

  def already_guessed?(letter)
    @guesses.any? { |guess| guess.upcase == letter.upcase }
  end

  def valid_letter?(letter)
    letter.respond_to?(:to_s) && letter.size == 1
  end

  def win?
    word.chars.all? { |word_letter| @guesses.include?(word_letter.upcase) }
  end

  def loss?
    incorrect_guesses.count >= number_of_turns
  end

  def letter_match?(letter)
    @word.upcase.include?(letter.upcase)
  end

  def correct_guesses_text
    text = ''
    @word.chars.each_with_index do |letter, index|
      if correct_guesses.include?(letter.upcase)
        text += "\e[4m#{letter}\e[0m"
      else
        text += '_'
      end
    end
    text
  end

  def all_guesses_text
    text = ''
    @guesses.each_with_index do |guess, index|
      display_letter = guess
      display_letter = "\e[4m#{display_letter}\e[0m" if letter_match?(guess)
      text += index == 0 ? '' : ' '
      text += display_letter
    end
    text
  end

  def self.save_path(save_name)
    File.join(SAVE_DIR, "#{save_name}.yaml")
  end

  def save(save_name)
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
    File.write(self.class.save_path(save_name), YAML.dump(self))
  end

  def self.existing_saves
    if Dir.exists?(SAVE_DIR)
      Dir[File.join(SAVE_DIR, "*.yaml")]
    else
      []
    end
  end

  def self.save_exists?(save_name)
    existing_saves.map { |save| File.basename(save_name, '.yaml') }.include?(save_name)
  end

  def self.load(save_name)
    if save_exists?(save_name)
      file = File.read(save_path(save_name))
      YAML.load(file)
    else
      raise SaveDoesntExistError.new("Save #{save_name} doesn't exist")
    end
  end

end
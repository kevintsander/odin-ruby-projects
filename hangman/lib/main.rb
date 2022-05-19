#frozen_string_literal: true

require_relative 'game'
require_relative 'game_display'
require_relative 'game_exceptions'
require_relative 'auto_word_loader'

word_loader_path = File.expand_path('../inputs/word-list.txt', __dir__)
word_loader = AutoWordLoader.new(word_loader_path)
game = Game.new(word_loader.word)
game_display = GameDisplay.new(game)

while game.status == :playing
  game_display.guess_prompt
  begin
    game.guess(gets.chomp)
  rescue LetterAlreadyGuessedError
    game_display.already_guessed
    next
  rescue NotALetterError
    game_display.not_a_letter
    next
  end
  game_display.result
end
#frozen_string_literal: true

require 'game'
require 'game_display'
require 'auto_word_loader'

word_loader_path = '../word-list.txt'
word_loader = new AutoWordLoader(word_loader_path)
game = Game.new(word_loader)
game_display = GameDisplay.new(game)

while game.status == playing
  game_display.guess_prompt
  game.guess(gets.chomp)
  game_display.result
end
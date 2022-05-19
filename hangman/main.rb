#frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/game_display'
require_relative 'lib/game_exceptions'
require_relative 'lib/auto_word_loader'


word_loader_path = File.expand_path('../inputs/word-list.txt', __dir__)
word_loader = AutoWordLoader.new(word_loader_path)
#game = Game.new(word_loader.word)
game = nil
def start_prompt
  puts 'Welcome to Hangman! Try to guess the word before you run out of tries!'
end

def load_prompt
  puts 'Would you like to load an existing game? (Y = yes)'
end

def load_name_prompt
  save_names = Game.existing_saves.map { |save| File.basename(save, ".yaml") }
  puts "Which game would you like to load:\n#{save_names.join("\n")}"
end

def clear
  system('clear') || system('cls')
end

start_prompt
if Game.existing_saves.count > 0
  load_prompt
  if gets.chomp.upcase == 'Y'
    load_name_prompt
    load_name = gets.chomp
    game = Game.load(load_name)
  end
end
game = Game.new(word_loader.word) unless game
game_display = GameDisplay.new(game)

game_display.result
while game.status == :playing
  game_display.guess_prompt
  input = gets.chomp.upcase
  if input == '1'
    game_display.save_name_prompt
    save_name = gets.chomp
    game.save(save_name)
    break
  end
  begin
    game.guess(input)
  rescue LetterAlreadyGuessedError
    game_display.already_guessed
    next
  rescue NotALetterError
    game_display.not_a_letter
    next
  end
  clear
  game_display.result
end
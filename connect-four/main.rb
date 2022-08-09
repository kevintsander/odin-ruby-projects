require './lib/board'
require './lib/game'

board = Board.new(6, 7)
game = Game.new(board)
game.play

require_relative 'lib/board'
require_relative 'lib/knight'

# Level order recursive search for move path
def knight_moves(startc, endc)
  queue = [] # queue will contain move paths
  moves = [startc] # current move path

  # Traverse until the latest move matches the end coordinate
  until moves.last == endc
    # for each possible move, add the new move to a copy of the current move list
    Knight::ALLOWED_MOVES.each do |movec|
      newc = move(moves.last, movec)
      if inbounds(newc) && !moves.include?(newc)
        queue << (moves.dup << newc)
      end
    end
    moves = queue.shift
  end
  moves
end

# Moves a coordinate
def move(startc, movec)
  [startc[0] + movec[0], startc[1] + movec[1]]
end

# Checks if a coordinate is in-bounds
def inbounds(coords)
  coords[0].between?(0, Board::MAX_BOUNDS[0]) &&
  coords[1].between?(0, Board::MAX_BOUNDS[0])
end

def print_moves(moves)
  puts "You made it in #{moves.size - 1} moves! Here's your path: "
  moves.each { |move| p move}
end

print_moves(knight_moves([0,0], [1,2]))
print_moves(knight_moves([0,0], [3,3]))
print_moves(knight_moves([3,3], [0,0]))
print_moves(knight_moves([3,3], [4,3]))
print_moves(knight_moves([7,7], [3,0]))

5.times do
  print_moves(knight_moves([rand(0..7), rand(0..7)], [rand(0..7), rand(0..7)]))
end
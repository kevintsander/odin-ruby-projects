# frozen_string_literal: true

require './lib/board'

describe Board do
  describe '#add_piece' do
    subject(:board_add) { described_class.new }

    context 'column is empty' do
      it 'adds a piece to bottom of matrix' do
        column = 3
        piece = '⚪'
        board_add.add_piece(piece, 3)
        expect(board_add.matrix[0][3]).to eq(piece)
      end
    end

    context 'column has a piece already' do
      it 'adds a piece on top of another piece' do
        column = 3
        piece1 = '⚪'
        board_add.add_piece(piece1, 3)
        piece2 = '⚫'
        board_add.add_piece(piece2, 3)
        expect(board_add.matrix[1][3]).to eq(piece2)
      end
    end
  end
end

describe '#connect_four_column?' do
  context 'connecting four of same piece in a column' do
    xit 'returns true' do
    end
  end

  context 'not four pieces connected in a column' do
    xit 'returns false' do
    end
  end
end

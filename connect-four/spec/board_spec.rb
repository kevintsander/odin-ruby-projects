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

  describe '#four_in_a_row?' do
    subject(:board_four) { described_class.new }

    context 'four of same piece adjacent in a row' do
      before do
        allow(board_four).to receive(:matrix).and_return(
          [[nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, '⚫', '⚫', '⚫', '⚫', nil],
           [nil, nil, nil, nil, nil, nil, nil]]
        )
      end

      it 'returns true' do
        result = board_four.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'four of same piece adjacent in a column' do
      before do
        allow(board_four).to receive(:matrix).and_return(
          [[nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, '⚫', nil, nil, nil, nil],
           [nil, nil, '⚫', nil, nil, nil, nil],
           [nil, nil, '⚫', nil, nil, nil, nil],
           [nil, nil, '⚫', nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil]]
        )
      end
      it 'returns true' do
        result = board_four.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'four of same piece adjacent in diagonally' do
      before do
        allow(board_four).to receive(:matrix).and_return(
          [[nil, nil, nil, '⚫', nil, nil, nil],
           [nil, nil, '⚫', nil, nil, nil, nil],
           [nil, '⚫', nil, nil, nil, nil, nil],
           ['⚫', nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil]]
        )
      end
      it 'returns true' do
        result = board_four.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'not four adjacent pieces in any direction' do
      before do
        allow(board_four).to receive(:matrix).and_return(
          [['⚫', '⚫', '⚪', '⚫', nil, nil, nil],
           ['⚪', '⚪', '⚪', nil, nil, nil, nil],
           ['⚫', '⚫', '⚫', nil, nil, nil, nil],
           ['⚫', nil, '⚪', nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil]]
        )
      end

      it 'returns false' do
        result = board_four.four_in_a_row?
        expect(result).to be(false)
      end
    end
  end

  describe '#full?' do
    subject(:board_full) { described_class.new }

    context 'board is not full' do
      before do
        allow(board_full).to receive(:matrix).and_return(
          [['⚫', '⚫', '⚪', '⚫', nil, nil, nil],
           ['⚪', '⚪', '⚪', nil, nil, nil, nil],
           ['⚫', '⚫', '⚫', nil, nil, nil, nil],
           ['⚫', nil, '⚪', nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil],
           [nil, nil, nil, nil, nil, nil, nil]]
        )
      end

      it 'returns false' do
        expect(board_full).not_to be_full
      end
    end

    context 'board is full' do
      before do
        allow(board_full).to receive(:matrix).and_return(
          [['⚫', '⚫', '⚪', '⚫', '⚪', '⚫', '⚪'],
           ['⚪', '⚪', '⚪', '⚫', '⚫', '⚪', '⚪'],
           ['⚫', '⚫', '⚫', '⚪', '⚫', '⚫', '⚫'],
           ['⚫', '⚪', '⚪', '⚫', '⚪', '⚫', '⚪'],
           ['⚫', '⚪', '⚫', '⚫', '⚪', '⚪', '⚫'],
           ['⚪', '⚫', '⚪', '⚪', '⚫', '⚪', '⚪']]
        )
      end

      it 'returns true' do
        expect(board_full).to be_full
      end
    end
  end
end

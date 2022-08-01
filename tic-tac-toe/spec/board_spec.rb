# frozen_string_literal: true

require_relative '../board'

describe TicTacToeBoard do
  subject(:board) { described_class.new }

  describe '#won_row?' do
    context 'when a row does not have 3 in a row' do
      it 'returns false' do
        board.instance_variable_set(:@board, [['O', nil, nil], %w[X X O], ['X', nil, nil]])
        expect(board).not_to be_won_row
      end
    end

    context 'when a row has 3 in a row' do
      it 'returns true' do
        board.instance_variable_set(:@board, [[nil, 'O', nil], %w[X X X], [nil, 'O', nil]])
        expect(board).to be_won_row
      end
    end
  end
end

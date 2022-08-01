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

  describe '#won_column?' do
    context 'when a column does not have 3 in a row' do
      it 'returns false' do
        board.instance_variable_set(:@board, [['O', nil, nil], %w[O X X], ['X', nil, 'O']])
        expect(board).not_to be_won_column
      end
    end

    context 'when a column has 3 in a row' do
      it 'returns true' do
        board.instance_variable_set(:@board, [['O', nil, nil], %w[O X X], ['O', 'X', nil]])
        expect(board).to be_won_column
      end
    end
  end

  describe '#won_diagonal?' do
    context 'when a diagonal does not have 3 in a row' do
      it 'returns false' do
        board.instance_variable_set(:@board, [['X', nil, nil], [nil, 'X', nil], %w[O X O]])
        expect(board).not_to be_won_diagonal
      end
    end

    context 'when a diagonal has 3 in a row' do
      it 'returns true' do
        board.instance_variable_set(:@board, [['X', nil, nil], ['O', 'X', nil], ['O', nil, 'X']])
        expect(board).to be_won_diagonal
      end
    end
  end

  describe '#location_open?' do
    context 'when the location has already been played' do
      it 'returns false' do
        board.instance_variable_set(:@board, [['X', nil, nil], ['O', 'X', nil], ['O', nil, 'X']])
        row = 2
        col = 0
        expect(board).not_to be_location_open(row, col)
      end
    end

    context 'when the location has not been played' do
      it 'returns true' do
        board.instance_variable_set(:@board, [['X', nil, nil], ['O', 'X', nil], ['O', nil, 'X']])
        row = 1
        col = 3
        expect(board).to be_location_open(row, col)
      end
    end
  end

  describe '#update_board' do
    before do
      allow(board).to receive(:display_board).once
    end

    context 'board is being updated' do
      it 'sets board position to player name' do
        row = 1
        col = 2
        player = 'X'
        expect { board.update_board(player, row, col) }.to change {
                                                             board.instance_variable_get(:@board)[row][col]
                                                           }.to(player)
      end
    end
  end
end

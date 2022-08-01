# frozen_string_literal: true

require './lib/game'

describe TicTacToeGame do
  describe '#play_turn' do
    context 'user plays an open space' do
      let(:board) { instance_double(TicTacToeBoard) }
      subject(:game) { described_class.new('X', 'O', board) }

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('1', '1')
        allow(board).to receive(:location_open?).with(0, 0).and_return(true)
        allow(board).to receive(:update_board)
      end

      it 'does not display an error message' do
        player = 'X'
        expect(game).not_to receive(:space_taken_message)
        game.play_turn(player)
      end

      it 'sends update_board to board' do
        player = 'X'
        expect(board).to receive(:update_board).with('X', 0, 0)
        game.play_turn(player)
      end
    end
  end
end

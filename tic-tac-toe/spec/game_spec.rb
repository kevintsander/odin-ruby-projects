# frozen_string_literal: true

require './lib/game'

describe TicTacToeGame do
  let(:board) { instance_double(TicTacToeBoard) }
  subject(:game) { described_class.new('X', 'O', board) }

  describe '#play_turn' do
    context 'user plays an open space' do
      before do
        player = 'X'
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
        expect(board).to receive(:update_board).with(player, 0, 0)
        game.play_turn(player)
      end
    end

    context 'user plays a taken space once before playing an open space' do
      before do
        player = 'X'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('1', '1', '2', '2')
        allow(board).to receive(:location_open?).with(0, 0).and_return(false)
        allow(board).to receive(:location_open?).with(1, 1).and_return(true)
        allow(board).to receive(:update_board)
      end

      it 'displays an error message once' do
        player = 'X'
        expect(game).to receive(:space_taken_message).once
        game.play_turn(player)
      end

      it 'sends update_board to board' do
        player = 'X'
        expect(board).to receive(:update_board).with(player, 1, 1)
        game.play_turn(player)
      end
    end
  end

  describe '#play_game' do
    context 'player 1 wins on third turn' do
      before do
        allow(board).to receive(:won?).and_return(false, false, false, false, false, false, false, true)
        allow(game).to receive(:play_turn)
        allow(game).to receive(:win_message)
      end

      it 'sends a player 1 win message' do
        expect(game).to receive(:win_message).with('X').once
        game.play_game
      end

      it 'player 1 gets 3 turns' do
        expect(game).to receive(:play_turn).with('X').exactly(3).times
        game.play_game
      end

      it 'player 2 gets two turns' do
        expect(game).to receive(:play_turn).with('O').twice
        game.play_game
      end
    end
    context 'player 2 wins on third turn' do
      before do
        allow(board).to receive(:won?).and_return(false, false, false, false, false, false, false, false, true)
        allow(game).to receive(:play_turn)
        allow(game).to receive(:win_message)
      end

      it 'sends a player 2 win message' do
        expect(game).to receive(:win_message).with('O').once
        game.play_game
      end

      it 'player 1 gets 3 turns' do
        expect(game).to receive(:play_turn).with('X').exactly(3).times
        game.play_game
      end

      it 'player 2 gets 3 turns' do
        expect(game).to receive(:play_turn).with('O').exactly(3).times
        game.play_game
      end
    end
  end
end

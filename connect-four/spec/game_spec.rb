# frozen_string_literal:true

require './lib/game'

describe Game do
  describe '#validate_column_input' do
    let(:board) { double('board', rows: 6, columns: 7) }
    subject(:game_validate) { described_class.new(board) }

    context 'column is number in bounds' do
      it 'returns number' do
        input = '6'
        result = game_validate.validate_column_input(input)
        expect(result).to be(6)
      end
    end

    context 'column is number out of bounds' do
      it 'throws out of bounds error' do
        input = '9'
        expect { game_validate.validate_column_input(input) }
          .to raise_error(Game::OutOfBoundsInputError)
      end
    end

    context 'column is not a number' do
      it 'throws invalid argument error' do
        input = 'k'
        expect { game_validate.validate_column_input(input) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe '#get_column_input' do
    let(:board) { double('board', rows: 6, columns: 7) }
    let(:player) { double('player', name: 'Kevin') }
    subject(:game_input) { described_class.new(board) }

    context 'player enters valid input' do
      before do
        allow(game_input).to receive(:gets).and_return('4')
        allow(game_input).to receive(:puts)
      end

      it 'prompts user for input once' do
        expect(game_input).to receive(:gets).once
        game_input.get_column_input(player)
      end

      it 'returns valid input' do
        result = game_input.get_column_input(player)
        expect(result).to be(4)
      end
    end

    context 'player enters out of bounds input once, then valid input' do
      before do
        allow(game_input).to receive(:gets).and_return('9', '2')
        allow(game_input).to receive(:puts)
      end

      it 'prompts user for input twice' do
        expect(game_input).to receive(:gets).twice
        game_input.get_column_input(player)
      end

      it 'displays out of bounds error message then returns input' do
        error_msg = 'Out of bounds, must be between 0 and 6'
        expect(game_input).to receive(:puts).with(error_msg).once
        result = game_input.get_column_input(player)
        expect(result).to be(2)
      end
    end

    context 'player enters non-numeric input once, then valid input' do
      before do
        allow(game_input).to receive(:gets).and_return('k', '2')
        allow(game_input).to receive(:puts)
      end

      it 'prompts user for input twice' do
        expect(game_input).to receive(:gets).twice
        game_input.get_column_input(player)
      end

      it 'displays out of bounds error message then returns input' do
        error_msg = 'Invalid entry, must be a number between 0 and 6'
        expect(game_input).to receive(:puts).with(error_msg).once
        result = game_input.get_column_input(player)
        expect(result).to be(2)
      end
    end
  end

  describe '#get_player_name' do
    let(:board) { double('board') }
    let(:player) { double('player') }
    subject(:game_name) { described_class.new(board) }

    it 'prompts user for name and returns it capitalized' do
      allow(game_name).to receive(:puts)
      allow(game_name).to receive(:gets).and_return("kevin\n")
      result = game_name.get_player_name(1)
      expect(result).to eq('Kevin')
    end
  end

  describe '#validate_player_piece' do
    context 'one character entered' do
      xit 'returns token' do
      end
    end
    context 'zero or multiple characters entered' do
      xit 'returns '
    end
  end

  describe '#setup_player' do
    context 'game piece not taken' do
      xit 'prompts for name once' do
      end
      xit 'prompts for game piece once' do
      end
      xit 'creates a new instance of player and sets instance variable' do
      end
    end
  end

  describe '#play_turn' do
    xit 'switches players' do
    end
    xit 'sends #add_piece to board' do
    end
  end
end

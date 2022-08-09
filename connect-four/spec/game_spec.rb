# frozen_string_literal:true

require './lib/game'

describe Game do
  describe '#validate_column_input' do
    let(:board) { double('board', rows: 6, columns: 7) }
    subject(:game_validate) { described_class.new(board) }

    context 'column is number in bounds' do
      it 'returns number' do
        allow(board).to receive(:column_full?).and_return(false)
        input = '6'
        result = game_validate.validate_column_input(input)
        expect(result).to be(6)
      end
    end

    context 'column is number out of bounds' do
      it 'throws out of bounds error' do
        input = '9'
        expect { game_validate.validate_column_input(input) }
          .to raise_error(RangeError)
      end
    end

    context 'column is not a number' do
      it 'throws invalid argument error' do
        input = 'k'
        expect { game_validate.validate_column_input(input) }
          .to raise_error(ArgumentError)
      end
    end

    context 'column is full' do
      it 'throws out of bounds error' do
        allow(board).to receive(:column_full?).and_return(true)
        input = '6'
        expect { game_validate.validate_column_input(input) }
          .to raise_error(RangeError)
      end
    end
  end

  describe '#get_column_input' do
    let(:board) { double('board', rows: 6, columns: 7) }
    let(:player) { double('player', name: 'Kevin') }
    subject(:game_input) { described_class.new(board) }

    context 'player enters valid input' do
      before do
        allow(game_input).to receive(:gets).and_return('')
        allow(game_input).to receive(:validate_column_input).and_return(4)
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
        allow(board).to receive(:column_full?).and_return(false)
        allow(game_input).to receive(:gets).and_return('9', '2')
        allow(game_input).to receive(:puts)
      end

      it 'prompts user for input twice' do
        expect(game_input).to receive(:gets).twice
        game_input.get_column_input(player)
        board.display
      it 'displays out of bounds error message then returns input' do
        error_msg = 'Out of bounds, must select non-full row between 0 and 6'
        expect(game_input).to receive(:puts).with(error_msg).once
        result = game_input.get_column_input(player)
        expect(result).to be(2)
      end
    end

    context 'player enters non-numeric input once, then valid input' do
      before do
        allow(board).to receive(:column_full?).and_return(false)
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
      board.display
      game_validate.instance_variable_set(:@player2, player2)
      allow(player1).to receive(:piece)
      allow(player2).to receive(:piece)
      board.display

    context '2, w, or white entered' do
      it 'returns ⚫' do
        %w[1 w white].each do |input|
          result = game_validate.validate_game_piece(input)
          expect(result).to eq('⚪')
        end
      end
    end

    context 'one character entered' do
      it 'returns piece' do
        result = game_validate.validate_game_piece('⚫')
        expect(result).to eq('⚫')
      end
    end

    context 'nothing or multiple characters entered' do
      it 'raises error' do
        input = '⚫⚪'
        expect { game_validate.validate_game_piece(input) }
          .to raise_error(ArgumentError)
        input = ''
        expect { game_validate.validate_game_piece(input) }
          .to raise_error(ArgumentError)
      end
    end

    context 'nothing entered' do
      it 'raises error' do
        input = ''
        expect { game_validate.validate_game_piece(input) }
          .to raise_error(ArgumentError)
      end
    end

    context 'space entered' do
      it 'raises error' do
        input = ' '
        expect { game_validate.validate_game_piece(input) }
          .to raise_error(ArgumentError)
      end
    end

    context 'piece already taken' do
      it 'raises error' do
        allow(player1).to receive(:piece).and_return('⚫')
        allow(game_validate).to receive(:game_piece_taken).and_return(true)
        input = '⚫'
        expect { game_validate.validate_game_piece(input) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe '#get_player_game_piece' do
    let(:board) { double('board') }
    subject(:game_piece) { described_class.new(board) }

    before do
      allow(game_piece).to receive(:puts)
    end

    context 'valid game piece entered' do
      it 'asks for piece once and returns it' do
        allow(game_piece).to receive(:validate_game_piece).and_return('⚫')
        expect(game_piece).to receive(:gets).and_return('')

        result = game_piece.get_player_game_piece('Kevin')
        expect(result).to eq('⚫')
      end
    end

    context 'invalid game piece entered, then valid' do
      it 'ask for input twice and return' do
        calls = 0
        allow(game_piece).to receive(:validate_game_piece) do
          calls += 1
          raise ArgumentError if calls == 1

          '⚫'
        end
        allow(game_piece).to receive(:gets).and_return('')
        expect(game_piece).to receive(:gets).twice
        result = game_piece.get_player_game_piece('Kevin')
        expect(result).to eq('⚫')
      end
    end
  end

  describe '#setup_player' do
    let(:player) { double('player') }
    let(:board) { double('board') }
    subject(:game_player) { described_class.new(board) }

    it 'returns a new player' do
      allow(game_player).to receive(:get_player_name).and_return('Kevin')
      allow(game_player).to receive(:get_player_game_piece).and_return('⚫')
      player = game_player.setup_player(1)
      expect(player).not_to be_nil
    end
  end

  describe '#play_turn' do
    let(:player1) { double('player', name: 'Kevin', piece: '⚫') }
    let(:player2) { double('player', name: 'Ivy', piece: '⚪') }
    let(:board) { double('board', rows: 6, columns: 7) }
    subject(:game_turn) { described_class.new(board) }

    before do
      game_turn.instance_variable_set(:@current_player, player1)
      game_turn.instance_variable_set(:@player1, player1)
      game_turn.instance_variable_set(:@player2, player2)
      allow(board).to receive(:column_full?).and_return(false)
      allow(board).to receive(:add_piece)
      allow(game_turn).to receive(:puts)
      allow(game_turn).to receive(:gets).and_return("1\n")
    end

    it 'switches players' do
      game_turn.play_turn
      expect(game_turn.current_player).to eq(game_turn.player2)
    end

    it "sends #add_piece with player's piece to board" do
      expect(board).to receive(:add_piece).with('⚫', 1).once
      game_turn.play_turn
    end
  end

  describe '#display_game' do
    let(:player1) { double('player1', name: 'Kevin', piece: '⚫') }
    let(:player2) { double('player2', name: 'Ivy', piece: '⚪') }
    let(:board) { double('board', rows: 6, columns: 7) }
    subject(:game_display) { described_class.new(board) }

    before do
      game_display.instance_variable_set(:@player1, player1)
      game_display.instance_variable_set(:@player2, player2)
      allow(board).to receive(:add_piece)
      allow(game_display).to receive(:get_column_input).and_return(1)
    end

    context 'game is full' do
      before do
        allow(board).to receive(:four_in_a_row?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
        allow(game_display).to receive(:draw)
      end

      it 'game ends in a draw' do
        expect(game_display).to receive(:draw).once
        game_display.display_game
      end
    end

    context 'game has four in a row after player1 turn' do
      before do
        allow(board).to receive(:four_in_a_row?).and_return(true)
        allow(board).to receive(:full?).and_return(false)
        allow(game_display).to receive(:puts)
      end

      it 'game ends with player1 as winner' do
        expect(game_display).to receive(:winner).with(player1).once
        game_display.display_game
      end
    end

    context 'game has four in a row after player2 turn' do
      before do
        allow(board).to receive(:four_in_a_row?).and_return(false, true)
        allow(board).to receive(:full?).and_return(false)
        allow(game_display).to receive(:puts)
      end

      it 'game ends with player2 as winner' do
        expect(game_display).to receive(:winner).with(player2).once
        game_display.display_game
      end
    end
  end
end

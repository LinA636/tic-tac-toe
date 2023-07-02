require_relative '../lib/board_game'
require_relative '../lib/player'
require_relative '../lib/field'

describe BoardGame do
  let(:player1) {Player.new('X', 'Player1')}
  let(:player2) {Player.new('O', 'Player2')}

  subject(:game){described_class.new(player1, player2)}


  describe '#initialize' do
    context 'when creating a new board game with empty fields' do
      it 'has 9 fields' do
        expect(game.fields_arr.length).to eq(9)
      end

      it 'the fields status are set to false' do
        expect(game.fields_arr.all?{|field| !field.is_set}).to be true
      end

      it 'sets the current player to player_one' do 
        expect(game.current_player).to be(player1)
      end
    end
  end

  describe '#print_game' do
    # includes only prints and puts -> no test needed
  end

  describe '#check_victory' do
    context 'when there is no victory' do
      it 'returns flase' do
        expect(game.check_victory).to be false
      end
    end

    context 'when there is a horizontal victory' do
      before do
        row = 0
        game.fields_arr[row].is_set = true
        game.fields_arr[row+1].is_set = true
        game.fields_arr[row+2].is_set = true
        game.fields_arr[row].symbol = player1.symbol
        game.fields_arr[row+1].symbol = player1.symbol
        game.fields_arr[row+2].symbol = player1.symbol
      end

      it 'returns true' do
        expect(game.check_victory).to be true
      end
    end

    context 'when there is a vertical victory' do
      before do
        game.fields_arr[0].is_set = true
        game.fields_arr[3].is_set = true
        game.fields_arr[6].is_set = true
        game.fields_arr[0].symbol = player1.symbol
        game.fields_arr[3].symbol = player1.symbol
        game.fields_arr[6].symbol = player1.symbol
      end

      it 'returns true' do
        expect(game.check_victory).to be true
      end
    end

    context 'when there is a diagonal victory' do
      before do
        game.fields_arr[0].is_set = true
        game.fields_arr[4].is_set = true
        game.fields_arr[8].is_set = true
        game.fields_arr[0].symbol = player1.symbol
        game.fields_arr[4].symbol = player1.symbol
        game.fields_arr[8].symbol = player1.symbol
      end

      it 'returns true' do
        expect(game.check_victory).to be true
      end
    end
  end

  describe '#check_full_board' do
    context 'when board is not full' do
      it 'returns false' do
        expect(game.check_full_board).to be false
      end
    end

    context 'when board is full' do
      before do
        game.fields_arr.each do |field|
          field.is_set = true
          field.symbol = player1.symbol
        end  
      end

      it 'returns true' do
        expect(game.check_full_board).to be true
      end
    end
  end

  describe '#choose_field' do
    before do
      allow(game).to receive(:gets).and_return('10', '5')
    end

    it 'marks the selected field' do
      game.choose_field
      expect(game.fields_arr[4].is_set).to be true
      expect(game.fields_arr[4].symbol).to be(player1.symbol)
    end
  end

  describe '#actualise_current_player' do
    it 'updates the current player' do
      expect {game.actualise_current_player}.to change{game.current_player}.from(player1).to(player2)
    end
  end

  describe '#announce_winner' do
    before do
      allow(game).to receive(:actualise_current_player)
      game.current_player = player2
    end

    it 'announces the winner' do
      expect { game.announce_winner }.to output(/Congrats #{player2.name}, you won!/).to_stdout
    end
  end

  describe '#announce_tie' do
    it 'announces a tie' do
      text = /It's a tie. No one wins./
      expect {game.announce_tie}.to output(text).to_stdout
    end
  end

end
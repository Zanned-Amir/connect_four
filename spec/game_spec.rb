require_relative '../lib/game'

describe Game do
    let(:board) { Board.new }
    let(:game) { Game.new }

    describe '#initialize' do
        it 'creates two players and sets the current player to player 1' do
            expect(game.instance_variable_get(:@player1)).to be_instance_of(Player)
            expect(game.instance_variable_get(:@player2)).to be_instance_of(Player)
            expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player1))
        end
    end

    describe '#play' do
        it 'switches players and updates the board until there is a winner or the board is full' do
            allow(game).to receive(:switch_players).and_return(nil)
            allow(game).to receive(:puts).and_return(nil)
            allow(game).to receive(:print).and_return(nil)
            allow(game).to receive(:gets).and_return("0\n", "1\n", "2\n", "3\n", "4\n", "5\n", "6\n")
            allow(board).to receive(:set_mark).and_return(nil)
            allow(board).to receive(:display).and_return(nil)
            allow(board).to receive(:win?).and_return(false)
            allow(board).to receive(:full?).and_return(false, false, false, false, false, false, false, true)

            expect(game).to receive(:switch_players).exactly(7).times
            expect(board).to receive(:set_mark).exactly(7).times
            expect(board).to receive(:display).exactly(7).times

            game.play
        end
    end
end





class Board
    attr_accessor :redmark, :yellowmark, :emptymark, :grid
    def initialize
        @redmark = "\u2713"
        @yellowmark = "\u2717"
        @emptymark = " "
        @grid = Array.new(7) { Array.new(7, @emptymark) }
    end

    def display
        puts "___________________________________"
        puts "  0    1    2    3    4    5    6   "
        @grid.each do |row|
            row.each do |cell|
                print "| #{cell} |"
            end
            puts
            puts "__________________________________"
        end
        puts "  0    1    2    3    4    5    6   "
    end

    def set_mark(row, column, mark)
        @grid[row][column] = mark
    end

    def win?(mark)
        # Check horizontal win
        @grid.each do |row|
            return true if row.join.include?(mark * 4)
        end

        # Check vertical win
        @grid.transpose.each do |column|
            return true if column.join.include?(mark * 4)
        end

        # Check diagonal win (top-left to bottom-right)
        (0..3).each do |row|
            (0..3).each do |column|
                return true if [@grid[row][column], @grid[row+1][column+1], @grid[row+2][column+2], @grid[row+3][column+3]].join.include?(mark * 4)
            end
        end

        # Check diagonal win (top-right to bottom-left)
        (0..3).each do |row|
            (3..6).each do |column|
                return true if [@grid[row][column], @grid[row+1][column-1], @grid[row+2][column-2], @grid[row+3][column-3]].join.include?(mark * 4)
            end
        end

        false
    end

    def full?
        @grid.all? { |row| row.none? { |cell| cell == @emptymark } }
    end
end

class Player
    attr_accessor :name, :mark
    def initialize(name, mark)
        @name = name
        @mark = mark
        puts "Player #{name} is using #{mark}"
    end

    def turn(board)
        puts "Player #{name} is using #{mark}, it's your turn."
        move = get_valid_move(board)
        board.set_mark(move[:row], move[:column], mark)
    end

    private

    def get_valid_move(board)
        loop do
            puts "Please enter a column number (0-6) to place your mark:"
            column = gets.chomp.to_i
            if (0..6).include?(column)
                row = board.grid.transpose[column].rindex(board.emptymark)
                return { row: row, column: column } if row
            end
            puts "Invalid move. Please try again."
        end
    end
end

class Game
    attr_accessor :board
    def initialize
        @board = Board.new
        @player1 = Player.new("Player 1", @board.redmark)
        @player2 = Player.new("Player 2", @board.yellowmark)
        @current_player = @player1
    end

    def play
        loop do
            @board.display
            @current_player.turn(@board)
            if @board.win?(@current_player.mark)
                puts "Player #{@current_player.name} wins!"
                break
            elsif @board.full?
                puts "It's a tie!"
                break
            end
            switch_players
        end
    end

    private

    def switch_players
        @current_player = (@current_player == @player1) ? @player2 : @player1
    end
end


require_relative "board.rb"
class Game
    def initialize(size, bombs)
        @board= Board.new(size,bombs)
    end

    def play
        until @board.win? || @board.lose?
            puts @board.render

            action, pos= get_move
            perform_action(action,pos)
        end

        if @board.win?
            puts "YOU WON!!!!"
        elsif @board.lose?
            puts @board.reveal
        end
    end

    def get_move
        puts "Please enter the action you want to perform and position where you intend to perform it."
        inp= gets.chomp.split(",")
        [inp[0],[inp[1].to_i, inp[2].to_i]]
    end

    def perform_action(action, pos)
        tile= @board[pos]
        
        case action
        when 'f'
            tile.toggle_flag
        when 'e'
            tile.explore
        end
    end
end
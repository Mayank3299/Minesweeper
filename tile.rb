class Tile

    DISHA= [
        [-1,-1],
        [-1,0],
        [-1,1],
        [0,-1],
        [0,1],
        [1,-1],
        [1,0],
        [1,1]
    ]

    def initialize(board, pos)
        @board= board, @pos= pos   
        @bombed, @flagged, @explored= false, false, false
    end

    def flagged?
        @flagged
    end

    def bombed?
        @bombed
    end

    def explored?
        @explored
    end

    def plant_bomb
        @bombed= true
    end

    def toggle_flag
        @flagged= !@flagged unless explored?
    end

    def neighbours
        adjacent_neighbours= DISHA.map do |idx,idy|
            [pos[0] + idx, pos[1] + idy]
        end.select do |row,col|
            [row,col].all? do |coord|
                coord.between?(0,@board.grid_size-1)
            end
        end

        adjacent_neighbours.map(|pos| @board[pos])
    end

    def adjacent_bomb_count
        neighbours.select(&:bombed?).count
    end

    def explore
        return self if flagged?
        return self if explored?
        @explored= true
        if !bombed? && adjacent_bomb_count==0
            neighbours.each(&:explore)
        end
        self    
    end

    def render
        if flagged?
            "F"
        elsif explored?
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        else
            "*"
        end
    end

    def reveal
        # to fully show the board at the end of the game
        if flagged?
            bombed? ? "F" : "f"
        elsif bombed?
            explored? ? "X" : "B"
        else
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        end
    end

    
end
require_relative "tile.rb"

class Board
    
    attr_reader :grid_size

    def initialize(grid_size, num_bombs)
        @grid_size= grid_size
        @num_bombs= num_bombs

        generate_board
    end

    def [](pos)
        row,col= pos
        @grid[row][col]
    end

    def generate_board
        @grid= Array.new(@grid_size) do |row|
            Array.new(@grid_size) {|col| Tile.new(self,[row,col])
        end

        plant_bombs
    end

    def plant_bombs
        total_bombs=0
        while total_bombs < @num_bombs
            pos= Array.new(2) {rand(@grid_size)}
            
            tile= self[pos]
            next if tile.bombed?
            tile.plant_bomb
            total_bombs+=1
        end
    end
end 
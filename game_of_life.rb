=begin
Any live cell at time T with < 2 live neighbors dies (by underpopulation)
Any live cell at time T  with exactly 2 or 3 live neighbors survives
Any live cell at time T with > 3 live neighbors dies (by overpopulation)
Any dead cell with exactly 3 live neighbors becomes alive (by reproduction)

Alive = 1
Dead = 0

=end

class GameOfLife

    def initialize(state)
        @state = state
    end

    def print_state

        puts @state.inspect
    end
    
    def transition!
        @state = transition
    end

    def transition
        new_state = Array.new(@state.size){Array.new(@state[0].size)}

        for x in (0..@state.size-1)
            for y in (0..@state[0].size-1)
    
                value = sum_neighbors(x, y)
    
                if @state[x][y].zero?
                    # dead rule
                    if value == 3
                        new_state[x][y] = 1
                    else
                        new_state[x][y] = 0
                    end
    
                else 
                    # live rules
                    if value > 1 && value < 4
                        new_state[x][y] = 1 
                    else
                        new_state[x][y] = 0 
                    end
                end
            end
        end
    
        return new_state
     
    end


    def sum_neighbors(x, y)

        sum = 0

        for x_off in (-1..1)
            for y_off in (-1..1)
                unless (x_off == 0 && y_off == 0)
                    neighbor_x = x_off+x
                    neighbor_y = y_off+y
                    sum += @state[neighbor_x][neighbor_y] if in_bounds?(neighbor_x, neighbor_y)
         
                end
            end
        end
    
        return sum
    end

    def in_bounds?(x, y)
        if x >= 0 && x < @state.size
            if y >= 0 && y < @state[0].size
                return true
            end
        end

        return false
    end

    def next_and_print

        transition!
        print_state
    end
end


## Oscilator Test!

tstate = [
    [0,1,0],
    [0,1,0],
    [0,1,0],
    [0,0,0] 
]

game = GameOfLife.new tstate

game.next_and_print
game.next_and_print
game.next_and_print



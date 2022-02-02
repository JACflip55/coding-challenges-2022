good_puzzle = [
  [8, 3, 5, 4, 1, 6, 9, 2, 7],
  [2, 9, 6, 8, 5, 7, 4, 3, 1],
  [4, 1, 7, 2, 9, 3, 6, 5, 8],
  [5, 6, 9, 1, 3, 4, 7, 8, 2],
  [1, 2, 3, 6, 7, 8, 5, 4, 9],
  [7, 4, 8, 5, 2, 9, 1, 6, 3],
  [6, 5, 2, 7, 8, 1, 3, 9, 4],
  [9, 8, 1, 3, 4, 5, 2, 7, 6],
  [3, 7, 4, 9, 6, 2, 8, 1, 5]
]
def validate(row)
    return false unless (row.size == 9)
    
    for number in (1..9)
        return false unless row.include?(number)
    end
    
    # duplicates?
    
    return true
    
end
def validate_rows(puzzle)
    
    puzzle.each do |row|
       return false unless validate(row) 
    end
    
    return true
end
def validate_columns(puzzle)
    
    for i in (0..8)
       
        col = puzzle.map{ |row| row[i] }
        
        return false unless validate(col)
    end
    
    return true
    
end


def validate_matrices(puzzle)
    for n in (0..2)
        for m in (0..2)
            row = n*3
            col = m*3
            matrix = []
            for r in (row..row+2)
                for c in (col..col+2)
                    matrix << puzzle[r][c]
                end
            end
            
            puts "row #{row} column #{col}\n"
            puts matrix.inspect
            return false unless validate(matrix)
        end
    end
    return true
    
end
bad_puzzle = [
  [8, 3, 5, 4, 1, 6, 9, 2, 7],
  [2, 9, 6, 8, 5, 7, 4, 3, 1],
  [4, 1, 7, 2, 9, 3, 6, 5, 8],
  [5, 6, 9, 1, 3, 4, 7, 8, 2],
  [1, 2, 3, 6, 7, 8, 5, 4, 9],
  [7, 4, 8, 5, 2, 9, 1, 6, 3],
  [6, 7, 2, 7, 8, 1, 3, 9, 4],
  [9, 8, 1, 3, 4, 5, 2, 7, 6],
  [3, 7, 4, 9, 6, 2, 8, 1, 5]
]

test_arr = [1,2,3,4,5,6,7,8,9]
#puts validate test_arr
puts validate_matrices bad_puzzle
puts validate_matrices good_puzzle


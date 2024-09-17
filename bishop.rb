class Bishop < Piece
  def valid_moves(board)
    moves = []

    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

    directions.each do |dx, dy|
      x, y = @position
      loop do
        x += dx
        y += dy
        break unless bounds([x, y])
        if empty?([x, y], board)
          moves << [x, y]
        elsif can_attack([x, y], board)
          moves << [x, y]
          break
        else
          break
        end
      end
    end

    moves
  end
end

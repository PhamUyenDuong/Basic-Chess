class Knight < Piece
  def valid_moves(board)
    moves = []

    knight_moves = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

    knight_moves.each do |dx, dy|
      x, y = @position
      new_pos = [x + dx, y + dy]
      if bounds(new_pos)
        if empty?(new_pos, board) || can_attack(new_pos, board)
          moves << new_pos
        end
      end
    end

    moves
  end
end

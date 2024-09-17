class King < Piece
  def valid_moves(board)
    moves = []

    king_moves = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

    king_moves.each do |dx, dy|
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

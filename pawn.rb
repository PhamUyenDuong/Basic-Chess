class Pawn < Piece
  def valid_moves(board)
    moves = []
    x, y = @position
    direction = @color == 'white' ? 1 : -1

    # Move forward
    one_step = [x + direction, y]
    if bounds(one_step) && empty?(one_step, board)
      moves << one_step

      # Move two steps forward from the starting position
      two_steps = [x + 2 * direction, y]
      if (x == 1 && @color == 'white') || (x == 6 && @color == 'black')
        moves << two_steps if empty?(two_steps, board)
      end
    end

    # Capture diagonally
    capture_moves = [[x + direction, y + 1], [x + direction, y - 1]]
    capture_moves.each do |new_pos|
      if bounds(new_pos) && can_attack(new_pos, board)
        moves << new_pos
      end
    end

    moves
  end
end

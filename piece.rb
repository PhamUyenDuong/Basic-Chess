class Piece
  attr_accessor :position, :color

  def initialize(position, color, board)
    @position = position
    @color = color
    board[position[0]][position[1]] = self
  end

  def remove(position, board)
    board[position[0]][position[1]] = nil
  end

  def move_to(next_pos, board)
    if can_attack(next_pos, board)
      remove(next_pos, board)
    end
    remove([@position[0],@position[1]], board)
    @position = next_pos
    board[next_pos[0]][next_pos[1]] = self
  end

  def bounds(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end

  def empty?(position, board)
    board[position[0]][position[1]].nil?
  end

  def can_attack(next_pos, board)
    return false if empty?(next_pos, board)
    target = board[next_pos[0]][next_pos[1]]
    bounds(next_pos) && @color != target.color
  end
end
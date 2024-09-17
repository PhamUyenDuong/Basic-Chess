require_relative 'board'
require 'pry'

class Game
  attr_reader :board, :player

  def initialize
    @board = Chess.new
    @player = 'white'
  end

  def get_board
    @board.board
  end

  def parse_move(move)
    parts = move.split
    return unless parts.length == 2

    start_pos = parts[0].split(',').map(&:to_i)
    end_pos = parts[1].split(',').map(&:to_i)
    [start_pos, end_pos] if bounds(start_pos) && bounds(end_pos)
  end

  def play
    puts "\n    Welcome to Ruby Chess!\n"

    loop do
      @board.display
      puts "Player #{@player.capitalize}, enter your move in format '0,0 1,0' or press 'q' to quit:"
      move = gets.chomp
      break if move == 'q'

      if valid_input?(move)
        from_pos, to_pos = parse_move(move)
        piece = @board[from_pos[0], from_pos[1]]

        if piece.nil?
          puts "\nInvalid move: no piece at the starting position!\n"
        elsif piece.color != @player
          puts "\nInvalid move: not your piece!\n"
        elsif @board[to_pos[0], to_pos[1]] && piece.color == @board[to_pos[0], to_pos[1]].color
          puts "\nInvalid move: destination occupied by your own piece!\n"
        else
          if piece.valid_moves(@board.board).include?(to_pos)
            temp_board = deep_copy(@board.board)
            piece.move_to(to_pos, temp_board)

            if in_check?(find_king_position(@player), temp_board)
              puts "\nMove puts king in check. Invalid move.\n"
            else
              piece.move_to(to_pos, @board.board)
              if in_checkmate?(find_king_position(opponent_color))
                puts "\nCheckmate! #{@player.capitalize} wins!\n"
                break
              end
              @board[from_pos[0], from_pos[1]] = nil
              switch_player
            end
          else
            puts "\nInvalid move for the piece!\n"
          end
        end
      else
        puts "\nInvalid input format. Please try again.\n"
      end
    end
  end

  private

  def valid_input?(input)
    input.match?(/^\d,\d \d,\d$/)
  end

  def parse_move(move)
    from, to = move.split
    from_pos = from.split(',').map(&:to_i)
    to_pos = to.split(',').map(&:to_i)
    [from_pos, to_pos]
  end

  def switch_player
    @player = @player == 'white' ? 'black' : 'white'
  end

  def in_check?(king_position, board)
    opponent_pieces = find_opponent_pieces(opponent_color, board)

    opponent_pieces.any? do |piece|
      piece.valid_moves(board).include?(king_position)
    end
  end

  def in_checkmate?(king_position)
    return false unless in_check?(king_position, @board.board)

    king = @board[king_position[0], king_position[1]]
    king.valid_moves(@board.board).all? do |move|
      temp_board = deep_copy(@board.board)
      king.move_to(move, temp_board)
      in_check?(find_king_position(@player), temp_board)
    end
  end

  def find_opponent_pieces(color, board)
    pieces = []
    board.each do |row|
      row.each do |cell|
        pieces << cell if cell && cell.color == color
      end
    end
    pieces
  end

  def opponent_color
    @player == 'white' ? 'black' : 'white'
  end

  def deep_copy(board)
    Marshal.load(Marshal.dump(board))
  end

  def find_king_position(color)
    get_board.each do |row|
      row.each do |cell|
        return cell.position if cell && cell.is_a?(King) && cell.color == color
      end
    end
    nil
  end
end

game = Game.new
game.play

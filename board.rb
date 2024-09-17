require_relative 'piece'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'

class Chess 
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    (0..7).each do |i|
      Pawn.new([1, i], 'white', @board)
      Pawn.new([6, i], 'black', @board)
    end

    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |piece_class, i|
      piece_class.new([0, i], 'white', @board)
      piece_class.new([7, i], 'black', @board)
    end
  end

  # def board
  #   @board
  # end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, piece)
    @board[row][col] = piece
  end

  def display
    count = 7 
    puts "\n     0  1  2  3  4  5  6  7"
    puts "   -------------------------"
    @board.reverse_each do |row|
      print "#{count} | "
      row.each do |cell|
        print cell.nil? ? " ' " : " #{unicode_piece(cell)} "
      end
      print "| #{count} "
      count -= 1
      puts
    end
    puts "   -------------------------"
    puts "     0  1  2  3  4  5  6  7\n\n"
  end

  def unicode_piece(piece)
    case piece.class.to_s
    when 'King'
      piece.color == 'white' ? "\u265A" : "\u2654"
    when 'Queen'
      piece.color == 'white' ? "\u265B" : "\u2655"
    when 'Rook'
      piece.color == 'white' ? "\u265C" : "\u2656"
    when 'Bishop'
      piece.color == 'white' ? "\u265D" : "\u2657"
    when 'Knight'
      piece.color == 'white' ? "\u265E" : "\u2658"
    when 'Pawn'
      piece.color == 'white' ? "\u265F" : "\u2659"
    else
      ' '
    end
  end

end

# chess_game = Chess.new

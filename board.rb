require 'colorize'
require_relative 'piece'


class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.new } }
    fill_board
  end

  def fill_board
    0.upto(2) do |i|
      0.upto(7) do |j|
        pos = [i, j]
        self[pos] = Piece.new(self, pos, :top) if (i+j).odd?
      end
    end

    5.upto(7) do |i|
      0.upto(7) do |j|
        pos = [i, j]
        self[pos] = Piece.new(self, pos, :bottom) if (i+j).odd?
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def render
    top_color = :red
    bottom_color = :black
    color_options = {}
    print "  "
    0.upto(7) { |i| print "#{i} " } 
    print "\n"
    0.upto(7) do |i|
      print i
      0.upto(7) do |j|
        square = self[[i, j]]
        color_options[:background] = (i+j).odd? ? :green : :white
        print_square(square, color_options, top_color, bottom_color)
      end
      puts
    end
  end

  def print_square(square, color_options, top_color, bottom_color)
    if square.side == :top
      color_options[:color] = top_color
    elsif square.side == :bottom
      color_options[:color] = bottom_color
    end
    print "#{square.symbol} ".colorize(color_options)
  end

  def dup
    new_board = Board.new
    0.upto(7) do |i|
      0.upto(7) do |j|
        pos = [i, j]
        new_board[pos] = self[pos].dup(new_board)
      end
    end

    new_board
  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  piece = board[[2, 3]]
  board[[3, 2]] = Piece.new(board, [3, 2], :bottom)
  board[[6, 3]] = NullPiece.new
  board.render
  p piece.valid_jump?( [4, 1] )
end

require_relative 'board'
require_relative 'player.rb'

class Piece
  attr_reader :symbol, :pos, :color
  attr_accessor :moved, :pos, :board

  def initialize (color, pos, board, moved = false)
    @color, @pos, @board, @moved = color, pos, board, moved
  end


  def move_into_check?(new_pos)
    new_board = Board.deep_dup(board)
    new_board.move!(pos, new_pos)
    new_board.in_check?(color, true)
  end

  def dup(new_board)
    self.class.new(color, pos, new_board)
  end

end

class SlidingPiece < Piece
  def possible_moves(pos, direction)
    possible_moves = []
    offsets = []
    case direction
    when :diag
      offsets = [ [1, 1], [-1, 1], [1, -1], [-1, -1] ]
    when :lateral
      offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
    end
    offsets.each do |offset|
      possible_moves += sliding_moves_helper(pos, offset, color)
    end

    possible_moves
  end

  def sliding_moves_helper(pos, offset, color)
    new_pos = [pos[0]+offset[0], pos[1]+offset[1]]
    if !@board.on_board?(new_pos)
      return []
    elsif !@board.occupied?(new_pos)
      return [new_pos] + sliding_moves_helper(new_pos, offset, color)
    elsif @board[new_pos].color != color
      return [new_pos]
    else
      return []
    end
  end
end

class SteppingPiece < Piece
  attr_reader :color

  def initialize(color, pos, board, moved = false)
    super
    create_directions
  end

  def possible_moves
    possible_moves = []
    @possible_directions.each do |offset|
      possible_moves += stepping_moves_helper(pos, offset, @color )
    end

    possible_moves
  end

  def stepping_moves_helper(pos, offset, color)
    new_pos = [pos[0]+offset[0], pos[1]+offset[1]]
    if !@board.on_board?(new_pos)
      return []
    elsif !@board.occupied?(new_pos)
      return [new_pos]
    elsif @board[new_pos].color != color
      return [new_pos]
    else
      return []
    end
  end
end


#Sliding pieces
class Rook < SlidingPiece
  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265C"
  end

  def possible_moves
    super(@pos, :lateral)
  end
end

class Bishop < SlidingPiece
  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265D"
  end

  def possible_moves
    super(@pos, :diag)
  end
end

class Queen < SlidingPiece
  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265B"
  end

  def possible_moves
    result = super(@pos, :lateral)
    result +=  super(@pos, :diag)
  end
end

#Stepping pieces
class King < SteppingPiece

  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265A"
  end

  def create_directions
    @possible_directions = [
      [1,1], [1,-1], [-1, -1], [-1, 1],
      [0,1], [0, -1], [1, 0], [-1, 0]
    ]
  end

end

class Pawn < SteppingPiece
  attr_reader :direction, :color

  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265F"
  end

  def create_directions
    if color == :black
      @direction = 1
    else
      @direction = -1
    end
  end

  def possible_moves
    pawn_moves_helper(pos, direction, color, moved)
  end

  def pawn_moves_helper(pos, direction, color, moved)
    results = []
    new_pos = [pos[0] + direction, pos[1]]
    results << new_pos if @board.on_board?(new_pos) && !@board.occupied?(new_pos)

    if !moved && results.include?(new_pos)
      next_pos = new_pos.dup
      next_pos[0] += direction
      if @board.on_board?(next_pos) && !@board.occupied?(next_pos)
        results << next_pos
      end
    end

    diags = [[new_pos[0], pos[1] + 1], [new_pos[0], pos[1] - 1]]
    diags.each do |position|
      if @board.on_board?(position) && @board.occupied?(position) && @board[position].color != color
        results << position
      end
    end


    results
  end

end

class Knight < SteppingPiece
  # MOVE_DIRS = []
  def initialize(color, pos, board, moved = false)
    super
    @symbol = "\u265E"
  end

  def move_dirs
    MOVE_DIRS
  end

  def create_directions
    @possible_directions = [
      [2, 1], [2,-1], [1, 2], [1, -2],
      [-1, 2], [-1, -2], [-2, 1], [-2, -1]
    ]
  end
end


if __FILE__ == $PROGRAM_NAME

end

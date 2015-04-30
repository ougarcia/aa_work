class Piece
  attr_reader :symbol, :pos, :color
  attr_accessor :moved, :pos

  def initialize (pos, board, color, side)
    @pos, @board, @color, @side =  pos, board, color, side
    @moved = false
  end

  def move_into_check?(new_pos)
    new_board = Board.deep_dup(@board)
    new_board.move!(pos, new_pos)
    new_board.in_check?(color)
  end

  def dup(new_board)
    self.class.new(pos.dup, new_board, @color, @side)
  end

  def movement_helper(pos, offset, color)
    new_pos = [pos[0] + offset[0], pos[1] + offset[1]]
    if !@board.on_board?(new_pos)
      return []
    elsif !@board.occupied?(new_pos)
      [new_pos] + (self.sliding? ? movement_helper(new_pos, offset, color) : [])
    elsif @board[new_pos].color != color
      return [new_pos]
    else
      return []
    end
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
      possible_moves += movement_helper(pos, offset, color)
    end

    possible_moves
  end


  def sliding?
    true
  end
end

class SteppingPiece < Piece
  attr_reader :color

  def initialize(pos, board, color, side)
    super
    create_directions
  end

  def possible_moves
    possible_moves = []
    @possible_directions.each do |offset|
      possible_moves += movement_helper(pos, offset, color)
    end

    possible_moves
  end

  def sliding?
    false
  end
end


#Sliding pieces
class Rook < SlidingPiece
    def initialize(pos, board, color, side)
    super
    @symbol = "\u265C"
  end

  def possible_moves
    super(@pos, :lateral)
  end
end

class Bishop < SlidingPiece
  def initialize(pos, board, color, side)
    super
    @symbol = "\u265D"
  end

  def possible_moves
    super(@pos, :diag)
  end

end

class Queen < SlidingPiece
  def initialize(pos, board, color, side)
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

  def initialize(pos, board, color, side)
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

  def initialize(pos, board, color, side)
    super
    @symbol = "\u265F"
  end

  def create_directions
    @direction = (@side == :top ? 1 : -1)
  end

  def possible_moves
    pawn_moves_helper(pos, direction, color)
  end

  def pawn_moves_helper(pos, direction, color)
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
  def initialize(pos, board, color, side)
    super
    @symbol = "\u265E"
  end

  def create_directions
    @possible_directions = [
      [2, 1], [2,-1], [1, 2], [1, -2],
      [-1, 2], [-1, -2], [-2, 1], [-2, -1]
    ]
  end
end

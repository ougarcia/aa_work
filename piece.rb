# make sure they don't step onto pieces that are already occupied
require_relative 'game' # just for debugging. need InvalidMoveError
class Piece

  DELTAS = [
   [1, -1],
   [1, 1]
  ]
  attr_reader :side, :symbol, :steps, :pos, :king
  #added :pos for debugging

  def initialize(board, pos, side, king = false)
    @board, @pos, @side = board, pos, side
    @king = king
    @symbol = "\u2B24"
    @opposite_side = (side == :top) ? :bottom : :top
    make_steps
  end

  def make_steps
    direction = (side == :top) ? 1 : -1
    @steps = DELTAS.map { |delta| [ delta[0] * direction, delta[1] ] }
  end

  def king?
    @king
  end

  def move(end_pos)
    @board[@pos] = NullPiece.new
    @board[end_pos] = self
    @pos = end_pos
  end


  def perform_moves!(move_sequence)
    if move_sequence.length == 1
      perform_move!(move_sequence.shift)
    else
     until move_sequence.empty?
      perform_jump(move_sequence.shift)
     end
    end 
  end


  def perform_move!(move)
    raise InvalidMoveError unless valid?(move)
    if valid_slide?(move)
      perform_slide(move)
    elsif valid_jump?(move)
      perform_jump(move)
    else
      raise InvalidMoveError
    end
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end

  def valid_move_seq?(move_sequence)
    move_sequence = Piece.deep_dup(move_sequence)
    new_board = @board.dup
    new_piece = new_board[@pos]
    begin
      new_piece.perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    end

    true
  end

  def perform_slide(end_pos)
    step_moves = next_steps(@pos)
    raise InvalidMoveError unless step_moves.include?(end_pos)
    move(end_pos)
  end

  def valid_slide?(end_pos)
    step_moves = next_steps(@pos)
    step_moves.include?(end_pos)
  end

  def valid?(move)
    booleans = []
    booleans << (move.all? { |x| x.between?(0, 7) } )
    booleans << (move.inject(:+).odd?)
    booleans << (empty?(move))

    booleans.all?
  end

  def empty?(pos)
    @board[pos].is_a? NullPiece
  end

  def perform_jump(end_pos) 
    raise InvalidMoveError unless valid_jump?(end_pos)
    if next_steps(next_steps(@pos, :left), :left) == end_pos
      enemy_piece = next_steps(@pos, :left)
    elsif next_steps(next_steps(@pos, :right), :right) == end_pos
      enemy_piece = next_steps(@pos, :right)
    end
    move(end_pos)
    @board[enemy_piece] = NullPiece.new
  end

  def valid_jump?(end_pos)
    [:left, :right].each do |direction|
      enemy_location = next_steps(@pos, direction)
      final_position = next_steps(enemy_location, direction)
      booleans = []
      booleans << (@board[enemy_location].side == @opposite_side)
      booleans << (@board[final_position].side == nil)
      booleans << (end_pos == final_position)
      return true if booleans.all?
    end

    false
  end


  def next_steps(pos, direction = :both)
    case direction
    when :both
      [next_steps(pos, :left), next_steps(pos, :right)]
    when :left
      Piece.sum_arrays(@steps[0], pos)
    when :right
      Piece.sum_arrays(@steps[1], pos)
    end
  end

  def self.sum_arrays(arr1, arr2)
    (0...arr1.length).map { |i| arr1[i] + arr2[i] }
  end

  def dup(new_board)
    Piece.new(new_board, @pos.dup, side, self.king)
  end

  def self.deep_dup(obj)
    if obj.is_a? Array
      result = []
      obj.each do |sub_object|
        result << Piece.deep_dup(sub_object)
      end

      result
    else
      obj
    end

    
  end

end


class NullPiece
  attr_reader :side, :symbol

  def initialize
    @symbol = " "
    @side = nil
  end

  def dup(new_board)
    NullPiece.new
  end
end


if __FILE__ == $PROGRAM_NAME

end

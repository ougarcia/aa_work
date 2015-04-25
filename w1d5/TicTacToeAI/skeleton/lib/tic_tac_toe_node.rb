require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator || @board.tied?
        return false
      end
    elsif evaluator == next_mover_mark
      self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    elsif evaluator != next_mover_mark
      self.children.each do |child|
        return true if child.losing_node?(evaluator)
      end
    end

    true
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner != evaluator || @board.tied?
        return false
      end
    elsif evaluator == next_mover_mark
      self.children.each do |child|
        return true if child.winning_node?(evaluator)
      end
    elsif evaluator != next_mover_mark
      self.children.all do |child|
        child.winning_node?(evaluator)
      end
    end

    true
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []

    empty_positions = []
    (0..2).each do |i|
      (0..2).each { |j| empty_positions << [i, j] if @board.empty?([i, j]) }
    end
    empty_positions.each do |empty_position|
      new_board = @board.dup
      new_board[empty_position] = @next_mover_mark
      new_mover_mark = switch_mark(@next_mover_mark)
      result << TicTacToeNode.new(new_board, new_mover_mark, empty_position)
    end

    result
  end

  def switch_mark(mark)
    mark == :x ? :o : :x
  end

end

example = TicTacToeNode.new(Board.new, :x)
# p example.children

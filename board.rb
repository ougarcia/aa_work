require_relative 'pieces'

class Board
  def self.deep_dup(old_board)
    new_board = Board.new
    (0..7).each do |i|
      (0..7).each do |j|
        pos = [i, j]
        if old_board[pos] == false
          new_board[pos] = false
        else
          new_board[pos] = old_board[pos].dup(new_board)
        end
      end
    end

    new_board
  end

  def initialize
    @grid = Array.new(8) { Array.new(8) {false} }
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    valid_moves = piece.possible_moves.reject { |move| piece.move_into_check?(move) }
    if valid_moves.include?(end_pos)
      move!(start_pos, end_pos)
    else
      raise InvalidMoveError
    end
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].moved = true
    self[start_pos] = false
    self[end_pos].pos = end_pos
  end

  def checkmate?(player)
    moves = []
    if in_check?(player.color)
      my_pieces = get_pieces(player.color)
      my_pieces.each do |my_piece|
        moves += my_piece.possible_moves.reject { |move| my_piece.move_into_check?(move) }
      end
      moves.empty?
    else
      false
    end
  end


  def get_pieces(color)
    @grid.flatten.select{|piece| piece != false && piece.color == color}
  end

  def in_check?(color)
    enemy = (color == :red ? :blue : :red)
    end_positions = []
    get_pieces(enemy).each do |enemy_piece|
      end_positions += enemy_piece.possible_moves
    end
    end_positions.each { |end_pos| return true if self[end_pos].class == King }

    false
  end

  def render
    colorize_options = {}
    print "  "
    (0..7).each { |i| print "#{i} "}
    puts
    @grid.each.with_index do |row, i|
      print i
      row.each.with_index do |el, j|
        colorize_options[:background] = (i+j).odd? ? :black : :white
        if el == false
          print "  ".colorize(colorize_options)
        else
          if el.color == :red
            colorize_options[:color] = :red
          else
            colorize_options[:color] = :blue
          end
          print "#{el.symbol} ".colorize(colorize_options)
        end
      end
      print "\n"
    end
    puts
  end

  def [](pos)
    #y axis has positive heading down
    row, column = pos
    @grid[row][column]
  end

  def []=(pos, piece)
    row, column = pos
    @grid[row][column] = piece
  end

  def on_board?(pos)
    pos.all? { |x| x.between?(0, 7)}
  end

  def occupied?(pos)
    self[pos] != false
  end

  def empty_square?(pos)
    on_board?(pos) && !occupied?(pos)
  end

  def piece_at(pos)
    self[pos]
  end
end

if __FILE__ == $PROGRAM_NAME
end

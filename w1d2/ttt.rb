# tldc
class Board
  attr_reader :board
  def initialize
    @board = Array.new(3) { Array.new(3) { ' ' } }
  end

  def place_mark(pos, mark)
    row = pos[0]
    column = pos[1]
    board[row][column] = mark
  end

  def render
    one = "\t" + board[0].join('|')
    two = "\t" + board[1].join('|')
    three = "\t" + board[2].join('|')
    gap = "\n\t-----\n"
    print "\n#{[one, two, three].join(gap)}\n\n"
  end
end

# top level documentation comment
class Game
  attr_reader :cpu, :human
  def initialize(human, cpu)
    @human = human
    @cpu = cpu
    @board = Board.new
    @winner = nil
    @human.show_board(@board)
    @cpu.show_board(@board)
  end

  def rows
    @board.board
  end

  def columns
    all_columns = []
    (0..2).each do |i|
      column = []
      @board.board.each { |row| column << row[i] }
      all_columns << column
    end
    all_columns
  end

  def diagonals
    all_diagonals = Array.new(2) { [] }
    (0..2).each do |i|
      all_diagonals[0] << @board.board[i][i]
      all_diagonals[1] << @board.board[2 - i][i]
    end
    all_diagonals
  end

  def win
    @board.render
    puts "#{@winner} wins!"
  end

  def won?
    arrays = columns + rows + diagonals
    if arrays.include?([:x, :x, :x])
      @winner = :x
    elsif arrays.include?([:o, :o, :o])
      @winner = :o
    end
    win if @winner
    @winner
  end

  def play
    i = 0
    until won?
      @board.render
      i.odd? ? cpu.take_turn : human.take_turn
      i += 1
    end
  end
end

# tldc
class Player
  attr_reader :mark
  def show_board(board)
    @board = board
  end

  def valid?(pos)
    row = pos[0]
    column = pos[1]
    target = @board.board[row][column]
    target == ' ' ? true : false
  end

  def take_turn
    pos = pick_pos
    @board.place_mark(pos, mark)
  end
end

# tldc
class HumanPlayer < Player
  def initialize
    @mark = :x
  end

  def pick_pos
    print "which row?\t"
    row = gets.chomp.to_i
    print "which column?\t"
    column = gets.chomp.to_i
    pos = [row, column]
    valid?(pos) ? pos : invalid
  end

  def invalid
    puts 'Invalid Move, try again.'
    pick_pos
  end
end

# tldc
class ComputerPlayer < Player
  def initialize
    @mark = :o
  end

  def pick_pos
    pos = []
    2.times { pos << rand(0..2) }
    valid?(pos) ? pos : pick_pos
  end
end

man = HumanPlayer.new
ai = ComputerPlayer.new
this_game = Game.new(man, ai)
this_game.play

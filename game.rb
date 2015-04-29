require_relative 'pieces.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require 'colorize'


class InvalidMoveError < StandardError
end

class Game
  HIGHER_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @board = Board.new
    @player1, @player2 = Player.new(:white), Player.new(:black)
    create_pieces(:black)
    create_pieces(:white)
  end

  def create_pieces(color)
    if color == :black
      back_row, pawn_row = 0, 1
    else
      back_row, pawn_row = 7, 6
    end

    HIGHER_PIECES.each_with_index do |piece_class, i|
      position = [back_row, i]
      @board[position] = piece_class.new(color, position, @board)
    end

    #create pawns
    0.upto(7) do |column|
      pos = [pawn_row, column]
      @board[pos] = Pawn.new(color, pos, @board)
    end
  end

  def show_board
    @board
  end

  def play
    loop do
      puts "Red's Turn"
      take_turn(@player1)
      if @board.checkmate?(@player2)
        puts "#{@player2.color.capitalize} is checkmated!"
        break
      end
      puts "Blue's Turn"
      take_turn(@player2)
      if @board.checkmate?(@player1)
        puts "#{@player1.color.capitalize} is checkmated!"
        break
      end
    end
  end



  def take_turn(player)
    begin
      @board.render
      move = player.prompt
      if @board[move[0]] == false || @board[move[0]].color != player.color
        raise InvalidMoveError
      end
      @board.move(*move)
    rescue InvalidMoveError
      puts "Invalid Move!!!"
      retry
    end

    if @board.in_check?(:white)
      puts "White's in Check!!!!"
    end
    if @board.in_check?(:black)
      puts "Black's in Check!!!!"
    end
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Game.new
  board = game.show_board
  # board.move([1, 5], [2, 5])
  # board.move([6, 4], [4, 4])
  # board.move([1, 6], [3, 6])
  # board.move([7, 3], [3, 7] )
  # board.move([1, 5], [2, 5])
  game.play
end

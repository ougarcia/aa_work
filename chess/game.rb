require_relative 'board.rb'
require_relative 'human_player.rb'
require 'colorize'

class InvalidMoveError < StandardError
end

class Game
  HIGHER_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @board = Board.new
    @player1, @player2 = Player.new(:red), Player.new(:blue)
    create_pieces(:red, :bottom)
    create_pieces(:blue, :top)
  end

  def create_pieces(color, side)
    if side == :top
      back_row, pawn_row = 0, 1
    else
      back_row, pawn_row = 7, 6
    end

    HIGHER_PIECES.each_with_index do |piece_class, i|
      position = [back_row, i]
      @board[position] = piece_class.new(position, @board, color, side)
    end

    #create pawns
    0.upto(7) do |column|
      pos = [pawn_row, column]
      @board[pos] = Pawn.new(pos, @board, color, side)
    end
  end

  def play
    current_player = @player1
    until @board.checkmate?(current_player)
      puts "#{current_player.color.capitalize}'s Turn"
      take_turn(current_player)
      current_player = other_player(current_player)
    end

    puts "#{current_player.color.capitalize} is checkmated!"
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
    other_color = other_player(player).color
    if @board.in_check?(other_color)
      puts "#{other_color.capitalize}'s in Check!"
    end
  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Game.new
  board = game.show_board
  game.play
end

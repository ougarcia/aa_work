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
    @player1, @player2 = Player.new(:red, 1), Player.new(:blue, 2)
    create_pieces(@player1)
    create_pieces(@player2)
  end

  def create_pieces(player)
    if player.number == 2
      back_row, pawn_row = 0, 1
    else
      back_row, pawn_row = 7, 6
    end
    color = player.color

    HIGHER_PIECES.each_with_index do |piece_class, i|
      position = [back_row, i]
      @board[position] = piece_class.new(position, @board, player)
    end

    #create pawns
    0.upto(7) do |column|
      pos = [pawn_row, column]
      @board[pos] = Pawn.new(pos, @board, player)
    end
  end

  def show_board
    @board
  end

  def play
    current_player, other_player = @player1, @player2
    until @board.checkmate?(current_player)
      puts "#{current_player.color.capitalize}'s Turn"
      take_turn(current_player)
      current_player, other_player = other_player, current_player
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

    if @board.in_check?(@player1.color)
      puts "#{@player1.color.capitalize}'s in Check!!!!"
    end
    if @board.in_check?(@player2.color)
      puts "#{@player2.color.capitalize}'s in Check!!!!"
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

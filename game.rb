require_relative 'board'
require_relative 'player'

class InvalidMoveError < StandardError
  
end


class Game
  attr_reader :player1, :player2# for debugging

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:top, :red)
    @player2 = HumanPlayer.new(:bottom, :black)
  end

  def play
    player = @player1
    loop do# should be until loop
      @board.render
      puts "#{player.color.capitalize}'s turn"
      take_turn(player)
      player = swap_player(player)
    end
  end

  def swap_player(player)
    player == @player1 ? @player2 : @player1
  end

  def take_turn(player)
    begin
      start_coordinates = player.get_starting_piece
      unless valid_starting_piece?(player, start_coordinates)
        raise InvalidMoveError
      end
      starting_piece = @board[start_coordinates]
      move_sequence = player.get_move_sequence
      starting_piece.perform_moves(move_sequence)
    rescue InvalidMoveError
      puts "Try Again!"
      retry
    end
  end

  def valid_starting_piece?(player, start)
    start.all? { |x| x.between?(0, 7) } && player.side == @board[start].side
  end

end



if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end

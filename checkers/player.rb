# player class goes here

class HumanPlayer
  attr_reader :side, :color

  def initialize(side, color)
    @side, @color = side, color
  end

  def get_starting_piece
    print "Input start position "
    start_pos = gets.chomp.split(" ").map(&:to_i)
  end

  def get_move_sequence
    puts "Input move sequence, type done when finished"
    sequence = []
    user_input = ""
    until user_input == "done"
      user_input = gets.chomp
      sequence << user_input.split(" ").map(&:to_i) unless user_input == "done"
    end
    sequence
  end

end

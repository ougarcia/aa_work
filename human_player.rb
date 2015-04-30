class Player
  attr_reader :color, :number

  def initialize(color, number)
    @color = color
    @number = number
  end

  def prompt
    print "Enter starting point: "
    start = gets.chomp.split(" ").map(&:to_i)
    print "Enter ending point: "
    finish = gets.chomp.split(" ").map(&:to_i)

    [start, finish]
  end

end

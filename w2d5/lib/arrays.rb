require 'byebug'
class Array

  def my_uniq
    result = []
    self.each do |el|
      if result.include?(el)
        next
      else
        result << el
      end
    end

    result
  end

  def two_sum
    result = []
    (0...self.length-1).each do |i|
      ((i+1)...self.length).each do |j|
        result << [i, j] if [self[i], self[j]].inject(:+) == 0
      end
    end

    result
  end

  def my_transpose
    result = Array.new( self.length ) { Array.new(self.length) { 0 } }
    (0...self.length).each do |i|
      (0...self.length).each do |j|

        result[i][j] = self[j][i]

      end
    end

    result
  end

  def stock_picker
    first = nil
    last = nil
    dif = 0
    (0...self.length-1).each do |i|
      ((i+1)...self.length).each do |j|
        current_difference = self[j] - self[i]
        if current_difference > dif
          dif = current_difference
          first, last = i, j
        end
      end
    end
    dif > 0 ? [first, last] : nil
  end
end




class TowersOfHanoi

  attr_accessor :towers

  def initialize
    generate_towers
  end


  def generate_towers
    @towers = [
      [3, 2, 1],
      [],
      []
    ]
  end

  def render
    result = "\n"
    @towers.each do |tower|
     result << "#{tower}\n"
    end
    
    result
  end

  def move(from, to)
    if @towers[from].empty?
      raise
    elsif @towers[to].empty? || @towers[from].last < @towers[to].last
      @towers[to] << @towers[from].pop
    else
      raise
    end
  end

  def won?
    @towers == [ [], [], [3, 2, 1] ]
  end

end

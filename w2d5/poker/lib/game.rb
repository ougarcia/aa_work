class Game

  def initialize(*players)
    @deck = Deck.new
    @pot = 0
    @players = players.collect { |player| player }
  end

  def play
  end

end

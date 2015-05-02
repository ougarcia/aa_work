require_relative 'card'

class Deck
  attr_reader :cards
  SUITES = [:spades, :hearts, :clubs, :diamonds]
  VALUES = [
    :two, :three, :four,
    :five, :six, :seven, :eight,
    :nine, :ten, :jack, :queen,
    :king, :ace
    ]

  def initialize
    generate_cards
    shuffle_cards!
  end

  def generate_cards
    @cards = []
    cards = SUITES.product(VALUES)
    cards.each do |card|
      @cards << Card.new(*card)
    end
  end

  def shuffle_cards!
    @cards.shuffle!
  end

  def draw(num = 1)
    result = []
    num.times do
      result << @cards.pop
    end

    result
  end


end

if __FILE__ == $PROGRAM_NAME
  deck = Deck.new
  deck.shuffle!
end

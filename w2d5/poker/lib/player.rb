class DiscardError < StandardError
end


class Player
  attr_accessor :hand, :discarded

  def initialize(hand)
    @playing = false
    @hand = hand
    @discarded = []
  end

  def new_hand(updated_hand)
    @hand = updated_hand
  end

  def swap(cards, new_cards)
    # which cards do yo uwant to swap
    # three cards from the deck
    discard(cards)
    recieve(new_cards)

  end

  def discard(cards)
    raise DiscardError if cards.length > 3
    cards.each do |card|
      @discarded << @hand.hand.delete(card)
    end
  end

  def recieve(cards)
    cards.each { |card| @hand << card }
  end



end

class HumanPlayer < Player
end

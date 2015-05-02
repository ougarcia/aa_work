require 'byebug'

class Hand
  attr_accessor :hand_value, :hand

  def initialize(hand)
    @hand = hand  # an array of five cards
    @hand_value = set_hand_value
  end

  def set_hand_value
    if royal_flush?
      1_000_000_000
    elsif straight_flush?
      100_000_000
    elsif four_of_a_kind?
      10_000_000
    elsif full_house?
      1_000_000
    elsif flush?
      100_000
    elsif straight?
      10_000
    elsif three_of_a_kind?
      1_000
    elsif two_pair?
      100
    elsif one_pair?
      10
    else
      0
    end

  end

  def royal_flush?
    straight_flush? && royals?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    [:two, :three, :four,
     :five, :six, :seven, :eight,
     :nine, :ten, :jack, :queen,
     :king, :ace]
     cards = Hash.new(0)

     @hand.each do |card|
       cards[card.value] += 1
     end

     cards.any? { |card, count| count == 4 }
  end

  def full_house?
    cards = card_frequencies
    cards.keys.count == 2
  end

  def flush?
    @hand.all? {|card| @hand.first.suite == card.suite }
  end


  # refactor
  def straight?
    values = [
      :two, :three, :four,
      :five, :six, :seven, :eight,
      :nine, :ten, :jack, :queen,
      :king, :ace
    ]

    ordered_hand = []

    values.each do |value|
      @hand.each do |hand|
        if hand.value == value
          ordered_hand << hand
        end
      end
    end

    first_card = values.index(ordered_hand.first.value)
      values[first_card...first_card+5] == ordered_hand.map { |card| card.value }
  end

  def three_of_a_kind?
    cards = card_frequencies
    cards.values.any? { |value| value == 3 }
  end

  def two_pair?
    cards = card_frequencies

    count = 0
    cards.each do |card, frequency|
      if frequency == 2
        count += 1
      end
    end

    count == 2
  end

  def one_pair?
    cards = card_frequencies

    count = 0
    cards.each do |card, frequency|
      if frequency == 2
        count += 1
      end
    end

    count == 1
  end


  def royals?
    @hand.map { |card| card.value }.sort == [:ten, :jack, :queen, :king, :ace].sort
  end

  def card_frequencies

    cards = Hash.new(0)

    @hand.each do |card|
      cards[card.value] += 1
    end

    cards
  end

end

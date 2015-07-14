require 'relatives'
require 'rspec'

describe "Card" do
  subject(:card) { Card.new(:hearts, :ace) }

  # let(:possible_suites) { [:hearts, :clubs, :spades, :diamonds] }

  it "has a suite" do
    expect(card.suite).to be_a(Symbol)
  end

  it "has a value" do
    expect(card.value).to be_a(Symbol)
  end

end


describe "Deck" do
subject(:my_deck) { Deck.new }
  describe "#generate_cards" do
    it "Generates 52 unique cards" do
      expect(my_deck.cards.uniq.count).to eq(52)
    end

    it "Contains only Card objects" do
      expect(my_deck.cards).to all( be_a(Card) )
    end

    it "loses a card when drawn" do
      my_deck.draw(1)
      expect(my_deck.cards.count).to eq(51)
    end

  end

end

describe "Hand" do
  #cards
  # let(:jheart)
  #hands
  let(:royal_flush) { Hand.new([Card.new(:hearts, :ten), Card.new(:hearts, :jack), Card.new(:hearts, :queen), Card.new(:hearts, :king), Card.new(:hearts, :ace)])}
  let(:four_of_a_kind) { Hand.new([Card.new(:spades, :ten), Card.new(:hearts, :ten), Card.new(:diamonds, :ten), Card.new(:clubs, :ten), Card.new(:hearts, :two)]) }
  let(:full_house) { Hand.new( [Card.new(:hearts, :jack), Card.new(:spades, :jack), Card.new(:clubs, :jack), Card.new(:hearts, :two), Card.new(:diamonds, :two)]) }
  let(:three_of_a_kind) { Hand.new( [Card.new(:spades, :ten), Card.new(:hearts, :ten), Card.new(:diamonds, :four), Card.new(:clubs, :ten), Card.new(:hearts, :two)])}
  let(:two_pair) { Hand.new( [Card.new(:hearts, :jack), Card.new(:spades, :jack), Card.new(:clubs, :four), Card.new(:hearts, :two), Card.new(:diamonds, :two)])}
  let(:one_pair) { Hand.new( [Card.new(:hearts, :ten), Card.new(:diamonds, :ten), Card.new(:hearts, :queen), Card.new(:hearts, :king), Card.new(:hearts, :ace)] )}
  let(:nothing) { Hand.new( [Card.new(:hearts, :seven), Card.new(:diamonds, :ten), Card.new(:hearts, :queen), Card.new(:hearts, :king), Card.new(:hearts, :ace)] )}

  describe "#hand_value" do
    it "evaluates flushes and straights" do
      expect(royal_flush.hand_value).to eq(1_000_000_000)
    end

    it "evaluates four of a kind" do
      expect(four_of_a_kind.hand_value).to eq(10_000_000)
    end

    it "evaluates full house" do
      expect(full_house.hand_value).to eq(1_000_000)
    end

    it "evaluates three-of-a-kind" do
      expect(three_of_a_kind.hand_value).to eq(1_000)
    end

    it "evaluates two_pair" do
      expect(two_pair.hand_value).to eq(100)
    end


    it "evaluates one_pair?" do
      expect(one_pair.hand_value).to eq(10)
    end

    it "evaluates worthless hand" do
      expect(nothing.hand_value).to eq(0)
    end


  end


end

describe "Player" do
let(:deck) { Deck.new }
let(:hand) { Hand.new(Deck.new.draw(5))}
subject(:example_player) { Player.new(hand) }

  context "#initialize" do
    it "has a new hand" do
      expect(example_player.hand).to be_a(Hand)
    end
  end

  context "#swap" do

    it "adds old card to discard pile" do
      example_player.swap(hand.hand.first(2))
      expect(example_player.discarded.length).to eq(2)
    end

    it "raises an error if player tries to discard more than three cards" do
      expect { example_player.swap(hand.hand.first(4)) }.to raise_error(DiscardError)
    end

    it "got the new cards from the deck" do
      example_player
    end

    it "only up to three cards"


  end

  context "#bankroll" do
    it "diminishes upon betting"

    it "increases by pot amount on win"

  end

  context "#hand" do
    it "changes when the player swaps"

    it "is five cards"

  end

  context "#fold" do
    it "makes sure default is false"
    it "changes status to true once folded"
  end

  context "#raise" do
    it "decreases backroll by bet amount" #should this be here instead of bankroll
  end

  context "#see current game bet" do
  end

end

describe "Game" do

  context "pot" do
    it "starts at zero"

    it "increases by bet amount"

    it "is never negative"

    it "ends at zero"
  end

  context "#play" do
    # rotate through players
  end

  it "holds a deck"
  # fill in later
end

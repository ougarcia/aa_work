require 'arrays'
require 'rspec'
require 'byebug'

describe "#my_uniq" do
  subject(:my_array) { [1, 2, 1, 3, 3] }

  it "returns only unique elements" do
    expect(my_array.my_uniq).to eq([1, 2, 3])
  end
end

describe "#two_sum" do
  subject(:my_array) { [-1, 0, 2, -2, 1] }

  it "returns pairs of positions where the elements at thsoe positions sum to zero" do
    expect(my_array.two_sum).to eq( [ [0, 4], [2, 3] ] )
  end

  it "returns an empty array when there are no matching indexes" do
    my_array = [1, 2, 3, 4, 5]
    expect(my_array.two_sum).to eq([])
  end
end

describe "#my_transpose" do
  subject(:my_array) {
      [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

  }

  subject(:transposed_array) {
    [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
    ]
  }

  it "will convert between row-oriented and column-oriented representations" do
    expect(my_array.my_transpose).to eq(transposed_array)
  end
end

describe "#stock_picker" do
  subject(:stockprices) { [14, 5, 2, 10, 1, 56] }
  it "will find the best profit given stock values" do
    expect(stockprices.stock_picker).to eq([4,5])
  end

  subject(:no_valid) { [6, 5, 4, 3, 2, 1] }
  it "will return nil if bear market" do
    expect(no_valid.stock_picker).to eq(nil)
  end
end


context "TowersOfHanoi" do
  subject(:game) { TowersOfHanoi.new }

  describe "#render" do
    it "returns a string" do
      expect(game.render).to be_a(String)
    end
  end

  describe "#move" do
    context "valid moves" do
      it "only succeeds on valid moves" do
        game.move(0, 2)
        expect(game.towers).to eq([[3,2],[],[1]])
      end
    end

    context "invalid moves" do
      it "raises an error on invalid moves" do
        expect{ game.move(2, 0) }.to raise_error
      end

      it "raises an error when trying to move larger onto small" do
        expect { 2.times { game.move(0, 2) } }.to raise_error
      end
    end
  end

  describe "#won?" do
    context "when won" do
      it "should return true" do
        game.towers = [ [], [], [3, 2, 1] ]
        expect(game).to be_won 
        # can only use be true if expect takes an argument, not blcok
        # why?
      end
    end

    context "when not won" do
      it "should return false" do
        game.towers = [ [1], [2], [3] ]
        expect(game).to_not be_won
      end
    end

  end


end

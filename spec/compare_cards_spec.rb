require "spec_helper"

describe(Array) do
  describe("#sorted_distinct_values") do
    it("returns the card values sorted by count (higher count in front)") do
      card1 = Card.create(value: "2", suit: "s")
      card2 = Card.create(value: "3", suit: "s")
      card3 = Card.create(value: "2", suit: "d")
      card4 = Card.create(value: "3", suit: "d")
      card5 = Card.create(value: "2", suit: "h")

      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.sorted_distinct_values).to(eq([2,3]))
    end

    it("sorts the non-repeated values by value (higher value in front)") do
      card1 = Card.create(value: "2", suit: "s")
      card2 = Card.create(value: "a", suit: "s")
      card3 = Card.create(value: "2", suit: "d")
      card4 = Card.create(value: "j", suit: "d")
      card5 = Card.create(value: "k", suit: "h")

      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.sorted_distinct_values).to(eq([2,14,13,11]))
    end
  end
  describe("#compare_same_type") do
    it("returns the better full house") do
      card1 = Card.create(value: "2", suit: "s")
      card2 = Card.create(value: "2", suit: "d")
      card3 = Card.create(value: "2", suit: "h")
      card4 = Card.create(value: "a", suit: "s")
      card5 = Card.create(value: "a", suit: "d")
      card6 = Card.create(value: "3", suit: "s")
      card7 = Card.create(value: "3", suit: "d")
      card8 = Card.create(value: "3", suit: "h")
      card9 = Card.create(value: "4", suit: "s")
      card10 = Card.create(value: "4", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it("returns the high card") do
      card1 = Card.create(value: "a", suit: "s")
      card2 = Card.create(value: "3", suit: "d")
      card3 = Card.create(value: "4", suit: "h")
      card4 = Card.create(value: "5", suit: "s")
      card5 = Card.create(value: "7", suit: "d")
      card6 = Card.create(value: "8", suit: "s")
      card7 = Card.create(value: "9", suit: "d")
      card8 = Card.create(value: "j", suit: "h")
      card9 = Card.create(value: "k", suit: "s")
      card10 = Card.create(value: "a", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('returns the better two pair') do
      card1 = Card.create(value: "3", suit: "s")
      card2 = Card.create(value: "3", suit: "d")
      card3 = Card.create(value: "4", suit: "h")
      card4 = Card.create(value: "4", suit: "s")
      card5 = Card.create(value: "7", suit: "d")
      card6 = Card.create(value: "8", suit: "s")
      card7 = Card.create(value: "8", suit: "d")
      card8 = Card.create(value: "4", suit: "d")
      card9 = Card.create(value: "4", suit: "c")
      card10 = Card.create(value: "a", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('returns the better three of a kind hand') do
      card1 = Card.create(value: "k", suit: "s")
      card2 = Card.create(value: "k", suit: "d")
      card3 = Card.create(value: "k", suit: "h")
      card4 = Card.create(value: "4", suit: "s")
      card5 = Card.create(value: "7", suit: "d")
      card6 = Card.create(value: "k", suit: "s")
      card7 = Card.create(value: "k", suit: "d")
      card8 = Card.create(value: "k", suit: "h")
      card9 = Card.create(value: "4", suit: "c")
      card10 = Card.create(value: "a", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('returns the better pair hand') do
      card1 = Card.create(value: "j", suit: "s")
      card2 = Card.create(value: "k", suit: "d")
      card3 = Card.create(value: "j", suit: "h")
      card4 = Card.create(value: "4", suit: "s")
      card5 = Card.create(value: "7", suit: "d")
      card6 = Card.create(value: "q", suit: "s")
      card7 = Card.create(value: "5", suit: "d")
      card8 = Card.create(value: "6", suit: "h")
      card9 = Card.create(value: "a", suit: "c")
      card10 = Card.create(value: "q", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('returns the better high card hand') do
      card1 = Card.create(value: "j", suit: "s")
      card2 = Card.create(value: "a", suit: "d")
      card3 = Card.create(value: "q", suit: "h")
      card4 = Card.create(value: "4", suit: "s")
      card5 = Card.create(value: "7", suit: "d")
      card6 = Card.create(value: "j", suit: "d")
      card7 = Card.create(value: "q", suit: "d")
      card8 = Card.create(value: "a", suit: "h")
      card9 = Card.create(value: "7", suit: "c")
      card10 = Card.create(value: "2", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand1))
    end

    it('returns the better straight') do
      card1 = Card.create(value: "2", suit: "s")
      card2 = Card.create(value: "3", suit: "d")
      card3 = Card.create(value: "4", suit: "h")
      card4 = Card.create(value: "5", suit: "s")
      card5 = Card.create(value: "6", suit: "d")
      card6 = Card.create(value: "8", suit: "s")
      card7 = Card.create(value: "9", suit: "d")
      card8 = Card.create(value: "10", suit: "d")
      card9 = Card.create(value: "j", suit: "c")
      card10 = Card.create(value: "q", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('works for the special case of a wheel (A2345)') do
      card1 = Card.create(value: "A", suit: "s")
      card2 = Card.create(value: "2", suit: "d")
      card3 = Card.create(value: "3", suit: "h")
      card4 = Card.create(value: "4", suit: "s")
      card5 = Card.create(value: "5", suit: "d")
      card6 = Card.create(value: "2", suit: "s")
      card7 = Card.create(value: "3", suit: "d")
      card8 = Card.create(value: "4", suit: "d")
      card9 = Card.create(value: "5", suit: "c")
      card10 = Card.create(value: "6", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand2))
    end

    it('returns the better flush') do
      card1 = Card.create(value: "a", suit: "s")
      card2 = Card.create(value: "2", suit: "s")
      card3 = Card.create(value: "3", suit: "s")
      card4 = Card.create(value: "10", suit: "s")
      card5 = Card.create(value: "j", suit: "s")
      card6 = Card.create(value: "a", suit: "d")
      card7 = Card.create(value: "3", suit: "d")
      card8 = Card.create(value: "2", suit: "d")
      card9 = Card.create(value: "9", suit: "d")
      card10 = Card.create(value: "j", suit: "d")

      test_hand1 = [card1, card2, card3, card4, card5]
      test_hand2 = [card6, card7, card8, card9, card10]
      expect(test_hand1.compare_same_type(test_hand2)).to(eq(test_hand1))
    end
  end

  describe('is_straight') do
    it('returns whether or not an array of cards is a straight') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_straight).to(eq(true))
      # expect(random_method(test_hand)).to(eq(true))
    end
    it('returns whether or not an array of cards is a straight') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "7"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_straight).to(eq(false))
      # expect(random_method(test_hand)).to(eq(true))
    end
  end
  describe('is_flush') do
    it('returns whether or not an array of cards is a flush') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "7"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_flush()).to(eq(true))
    end

    it('returns whether or not an array of cards is a flush') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "7"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_flush()).to(eq(false))
    end
  end

  describe("is_full_house") do
    it("will determine if a hand is a full house") do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_full_house()).to(eq(true))
    end
    it("will determine if a hand is a full house") do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "4"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_full_house()).to(eq(false))
    end
    it("will determine if a hand is a full house") do
      card1 = Card.create({:suit => "s", :value => "3"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_full_house()).to(eq(true))
    end
  end

  describe('is_four_kind') do
    it('will determine if a hand is four of a kind') do
      card1 = Card.create({:suit => "s", :value => "3"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "3"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_four_kind()).to(eq(true))
    end

    it('will determine if a hand is four of a kind') do
      card1 = Card.create({:suit => "s", :value => "3"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_four_kind()).to(eq(false))
    end
  end
  describe('is_three_kind') do
    it('will determine if a hand is three of a kind') do
      card1 = Card.create({:suit => "s", :value => "3"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "1"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_three_kind()).to(eq(true))
    end

    it('will determine if a hand is three of a kind') do
      card1 = Card.create({:suit => "s", :value => "3"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_three_kind()).to(eq(false))
    end
  end

  #three cases where is_two_pair should be true
  describe('is_two_pair') do
    it('will determine if a hand is two pair') do
      card1 = Card.create({:suit => "s", :value => "1"})
      card2 = Card.create({:suit => "s", :value => "1"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "2"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_two_pair()).to(eq(true))
    end

    it('will determine if a hand is two pair') do
      card1 = Card.create({:suit => "s", :value => "1"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "2"})
      card4 = Card.create({:suit => "h", :value => "3"})
      card5 = Card.create({:suit => "s", :value => "3"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_two_pair()).to(eq(true))
    end

    it('will determine if a hand is two pair') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "3"})
      card4 = Card.create({:suit => "h", :value => "4"})
      card5 = Card.create({:suit => "s", :value => "4"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_two_pair()).to(eq(true))
    end



    #is_two_pair will be false
    it('will determine if a hand is two pair') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "6"})
      card5 = Card.create({:suit => "s", :value => "5"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_two_pair()).to(eq(false))
    end
  end

  describe("is_pair") do
    it("will determine if there is one pair in the hand") do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "6"})
      card5 = Card.create({:suit => "s", :value => "5"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_pair()).to(eq(true))
    end
    it("will determine if there is one pair in the hand") do
      card1 = Card.create({:suit => "s", :value => "1"})
      card2 = Card.create({:suit => "s", :value => "2"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "6"})
      card5 = Card.create({:suit => "s", :value => "5"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.is_pair()).to(eq(false))
    end
  end

  describe('what_type') do
    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "1"})
      card2 = Card.create({:suit => "s", :value => "1"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "h", :value => "6"})
      card5 = Card.create({:suit => "s", :value => "5"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("pair"))
    end

    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "h", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("straight"))
    end

    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "s", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("straight flush"))
    end

    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "4"})
      card2 = Card.create({:suit => "h", :value => "6"})
      card3 = Card.create({:suit => "s", :value => "4"})
      card4 = Card.create({:suit => "s", :value => "4"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("full house"))
    end

    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "2"})
      card2 = Card.create({:suit => "h", :value => "6"})
      card3 = Card.create({:suit => "s", :value => "6"})
      card4 = Card.create({:suit => "s", :value => "6"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("four of a kind"))
    end

    it('will determine the type of hand') do
      card1 = Card.create({:suit => "s", :value => "5"})
      card2 = Card.create({:suit => "h", :value => "3"})
      card3 = Card.create({:suit => "s", :value => "5"})
      card4 = Card.create({:suit => "s", :value => "5"})
      card5 = Card.create({:suit => "s", :value => "6"})
      test_hand = [card1, card2, card3, card4, card5]
      expect(test_hand.what_type()).to(eq("three of a kind"))
    end
  end
end

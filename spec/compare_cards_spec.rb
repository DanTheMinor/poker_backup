require "spec_helper"
include CompareCards

describe(CompareCards) do
  describe("compare_full_house") do
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
      expect(test_hand1.compare_full_house(test_hand2)).to(eq(test_hand2))
    end
  end
    describe("compare_high_card") do
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
        expect(test_hand1.compare_high_card(test_hand2)).to(eq(test_hand2))
      end
    end
end

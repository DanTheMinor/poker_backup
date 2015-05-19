require "spec_helper"

describe(Card) do

  describe("#true_value") do
    it("converts face cards to integer values") do
      card = Card.create(value: "j", suit: "s")
      expect(card.true_value).to(eq(11))
    end

    it("returns value for other cards") do
      card = Card.create(value: "10", suit: "s")
      expect(card.true_value).to(eq(10))
    end
  end
end

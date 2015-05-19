require 'spec_helper'

describe(Hand) do
  describe('#flop_deal') do
    it('deals first three cards to the board') do
      game = Game.create
      hand = game.hands.create(pot: 0)
      hand.flop_deal
      expect(Card.where(hand_id: hand.id).length).to(eq(3))
    end
  end
end

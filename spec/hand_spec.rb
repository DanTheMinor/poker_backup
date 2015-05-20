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


  describe("#declare_winner") do
    it('declares the correct winner') do
      game = Game.create
      player1 = game.players.create(name: "peter")
      player2 = game.players.create(name: "ben")
      hand = game.hands.create(pot: 0)
      player1.cards.create(value: "7", suit: "s")
      player1.cards.create(value: "2", suit: "c")
      player2.cards.create(value: "a", suit: "s")
      player2.cards.create(value: "a", suit: "c")
      hand.cards.create(value: "a", suit: "h")
      hand.cards.create(value: "3", suit: "h")
      hand.cards.create(value: "4", suit: "h")
      hand.cards.create(value: "2", suit: "d")
      hand.cards.create(value: "a", suit: "d")
      expect(hand.winner).to(eq(player2))
    end

    it('declares a tie if the players have the same strength hand') do
      game = Game.create
      player1 = game.players.create(name: "peter")
      player2 = game.players.create(name: "ben")
      hand = game.hands.create(pot: 0)
      player1.cards.create(value: "7", suit: "s")
      player1.cards.create(value: "4", suit: "c")
      player2.cards.create(value: "7", suit: "c")
      player2.cards.create(value: "3", suit: "d")
      hand.cards.create(value: "a", suit: "s")
      hand.cards.create(value: "a", suit: "c")
      hand.cards.create(value: "a", suit: "h")
      hand.cards.create(value: "a", suit: "d")
      hand.cards.create(value: "2", suit: "h")
      expect(hand.winner).to(eq('tie'))
    end
  end
end

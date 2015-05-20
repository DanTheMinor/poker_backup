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
      player1 = game.players.create(name: "peter", stack: 200)
      player2 = game.players.create(name: "ben", stack: 200)
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
      player1 = game.players.create(name: "peter", stack: 200)
      player2 = game.players.create(name: "ben", stack: 200)
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

  describe("#handle_choice") do
    it('changes the players\' turns and current round') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "call") #stack: 500
      player2 = game.players.create(name: "ben")
      hand = game.hands.create(pot: 0, current_round: "preflop")
      hand.handle_choice(player1, player2)
      expect(hand.current_round()).to(eq("preflop"))
      expect(player1.is_turn).to(eq(false))
    end

    it('changes the players\' turns and current round') do
      game = Game.create
      player1 = game.players.create(name: "peter") #stack: 500
      player2 = game.players.create(name: "ben", choice: "call")
      hand = game.hands.create(pot: 0, current_round: "flop")
      hand.handle_choice(player2, player1)
      expect(hand.current_round()).to(eq("turn"))
      expect(player1.is_turn).to(eq(true))
    end

    it('changes the players\' turns and current round') do
      game = Game.create
      player1 = game.players.create(name: "peter", stack: 0)
      player2 = game.players.create(name: "ben", choice: "fold", stack: 0)
      hand = game.hands.create(pot: 0, current_round: "flop")
      hand.handle_choice(player2, player1)
      expect(hand.current_round()).to(eq("game over"))
      expect(player1.is_turn).to(eq(true))
      expect(hand.winner_id).to(eq(player1.id))
    end
  end

  describe("#current_choices") do
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "call", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "preflop")
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'bet/raise']))
    end

    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: true) #stack: 500
      player2 = game.players.create(name: "ben", choice: "call", is_bb: false)
      hand = game.hands.create(pot: 0, current_round: "preflop")
      expect(hand.current_choices(player2, player1)).to(eq(['call', 'fold', 'bet/raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "new round", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'bet/raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "new round", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'bet/raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "raise", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player1, player2)).to(eq(['call', 'fold', 'bet/raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "raise", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['call', 'fold', 'bet/raise']))
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

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


  describe("#winner") do
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
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'raise']))
    end

    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: true) #stack: 500
      player2 = game.players.create(name: "ben", choice: "call", is_bb: false)
      hand = game.hands.create(pot: 0, current_round: "preflop")
      expect(hand.current_choices(player2, player1)).to(eq(['call', 'fold', 'raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "new round", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'bet']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "new round", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['check', 'bet']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "new round", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "raise", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player1, player2)).to(eq(['call', 'fold', 'raise']))
    end
    it('tells app what buttons to display based on player choices and round/hand') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: false) #stack: 500
      player2 = game.players.create(name: "ben", choice: "raise", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "flop")
      expect(hand.current_choices(player2, player1)).to(eq(['call', 'fold', 'raise']))
    end

    it('will end the game and process a winner if either player is all-in') do
      #This test is specifically for testing an all in
      #Player's hole cards and the community cards need to be populated manually (otherwise cards are random)
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: false, stack: 0)
      player2 = game.players.create(name: "ben", choice: "call", is_bb: true, stack: 100)
      hand = game.hands.create(pot: 500, current_round: "river")
      #Populate player cards and community cards
      player1.cards.create(value: "7", suit: "s")
      player1.cards.create(value: "2", suit: "c")
      player2.cards.create(value: "a", suit: "c")
      player2.cards.create(value: "a", suit: "d")
      hand.cards.create(value: "a", suit: "s")
      hand.cards.create(value: "a", suit: "h")
      hand.cards.create(value: "k", suit: "h")
      hand.cards.create(value: "k", suit: "d")
      hand.cards.create(value: "k", suit: "s")
      game.deal(player2)

      expect(hand.current_choices(player1, player2)).to(eq([]))
    end
  end

  describe('#deal_remaining') do
    it('will deal the remaining cards depending on current round') do
      game = Game.create
      hand = game.hands.create(pot: 0, current_round: "preflop")
      hand.deal_remaining()
      expect(hand.cards.length).to(eq(5))
    end
  end

  describe('#all_in_called?') do
    it('will return true if either player is all-in') do
      game = Game.create
      player1 = game.players.create(name: "peter", choice: "raise", is_bb: false, stack: 0) #stack: 500
      player2 = game.players.create(name: "ben", choice: "call", is_bb: true)
      hand = game.hands.create(pot: 0, current_round: "preflop")
      expect(hand.all_in_called?).to(eq(true))
    end
  end

  describe('#special_bet') do
    it('will return the fixnum value of a special bet') do
      game = Game.create
      player1 = game.players.create(name: "peter", stack: 100) #stack: 500
      hand = game.hands.create(pot: 101)
      expect(hand.special_bet("all in pawtneh", player1)).to(eq(100))
      expect(hand.special_bet("half pot", player1)).to(eq(50))
      expect(player1.stack()).to(eq(100))
      expect(hand.special_bet("pot", player1)).to(eq(101))
      expect(player1.update_chips(hand.special_bet("half pot", player1))).to(eq(50))
      expect(player1.stack()).to(eq(50))
    end
  end
end

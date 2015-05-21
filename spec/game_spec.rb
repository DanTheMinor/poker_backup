require 'spec_helper'

describe(Game) do
  it('populates card database') do
    Game.create()
    expect(Card.all.length).to(eq(52))
  end

  it('populates card database with cards with suits') do
    Game.create()
    expect(Card.all.first.suit).to(eq('s'))
  end

  it('populates card database with cards with values') do
    Game.create()
    expect(Card.all.first.value).to(eq('2'))
  end

  it('populates card database with cards with picture urls') do
    Game.create()
    expect(Card.all.first.url).to(eq('s2.png'))
  end

  describe('#deal') do
    it('deals one card to a player') do
      game = Game.create
      player = game.players.create(name: "Ben")
      game.deal(player)
      expect(player.cards.length).to(eq(2))
    end

    it('deals two differents cards to a player') do
      # 50.times do
      #   game = Game.create
      #   player = game.players.create(name: "Ben")
      #   game.deal(player)
      #   expect(player.cards[0] == player.cards[1]).to(eq(false))
      #
      #   game.destroy
      #   player.destroy
      #   Card.delete_all
      # end
    end

    # don't run unless you've got some time
    # it('deals two different hole cards to different players') do
    #   1000.times do
    #     game = Game.create
    #     player1 = game.players.create(name: "Ben")
    #     game.deal(player1)
    #     player2 = game.players.create(name: "Peter")
    #     game.deal(player2)
    #     all_cards = player1.cards + player2.cards
    #     expect(all_cards.uniq.length).to(eq(4))
    #
    #     game.destroy
    #     player1.destroy
    #     player2.destroy
    #     Card.delete_all
    #   end
    # end
  end

  describe('#new_hand') do
    it('switches the button from p1 to p2') do
      game = Game.create()
      player1 = game.players.create(stack: 200)
      player2 = game.players.create(stack: 200)
      game.new_hand
      expect(player2.is_bb).to(eq(true))
      expect(player1.is_bb).to(eq(false))
    end

    it('deals out 4 player hole cards') do
      game = Game.create()
      player1 = game.players.create(stack: 200)
      player2 = game.players.create(stack: 200)
      game.new_hand
      expect(Card.where(player_id: nil).length).to(eq(48))
    end

    it("resets hand_id's to nil" ) do
      game = Game.create()
      player1 = game.players.create(stack: 200)
      player2 = game.players.create(stack: 200)
      game.new_hand
      game.current_hand.flop_deal
      game.new_hand
      expect(Card.where(hand_id: nil).length).to(eq(52))
    end
  end
end


require 'spec_helper'
require ('pry')

describe(Player) do
  describe('#update_chips') do
    it('Subtracts the amount bet from the players stack') do
      game = Game.create
      player1 = game.players.create(stack: 5)
      player2 = game.players.create(stack: 10)
      game.new_hand
      player1.update_chips(2)
      expect(player1.stack()).to(eq(2))
    end
  end

  # describe('#post_blinds') do
  #   it('will remove 1 from small blind and 2 from big blind stack') do
  #     player1 = Player.create(stack: 5)
  #     player2 = Player.create(stack: 5)
  #     post_blinds
  #     expect()
  #   end
  # end
  # commented out as it relies on the hand class and should go there
  #
  #another method for the hand class
  #bet special amount for half pot, full pot, all in


  describe('#is_bb') do
    game = Game.create()
  end



end

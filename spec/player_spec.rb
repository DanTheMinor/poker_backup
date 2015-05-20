
require 'spec_helper'
require ('pry')

describe(Player) do
  describe('#call') do
    it('Subtracts the amount bet from the calling players stack') do
      player1 = Player.create(stack: 5)
      player1.call(2)
      expect(player1.stack()).to(eq(3))
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
  describe('#bet') do
    it('Subtracts the amount bet from the betting player') do
      player1 = Player.create(stack: 5)
      player1.bet(2)
      expect(player1.stack()).to(eq(3))
    end
  end

  describe('#is_bb') do
    game = Game.create()
  end



end

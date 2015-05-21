
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
end

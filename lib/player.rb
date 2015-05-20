class Player < ActiveRecord::Base
  has_many :cards


  #methods for player class

  #need to know:  player, min/max bet, options, option chosen, pot amount

  #pre-flop, small blind methods

  def post_blinds(bb, sb) #automatically post blinds

  end

  def call(bet) #subtract from player stack
    add_to_pot = 0
    player = self
    if player.stack < bet
      add_to_pot = player.stack()
      player.stack = 0
    else
      add_to_pot = bet
      player.stack -= bet
    end
    add_to_pot
  end

  def fold()

  end

end

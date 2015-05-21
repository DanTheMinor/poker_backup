class Player < ActiveRecord::Base
  has_many :cards
  belongs_to :game

  #methods for player class

  #need to know:  player, min/max bet, options, option chosen, pot amount

  #pre-flop, small blind methods

  def post_blinds(bb, sb) #automatically post blinds

  end

  def update_chips(bet) #subtract from player stack bet amount
    #returns amount to add to pot
    add_to_pot = 0
    if self.stack < bet
      add_to_pot = self.stack()
      self.update(stack: 0)
    else
      add_to_pot = bet
      self.update(stack: self.stack - bet)
    end
    #update the pot the player belongs to
    pot = self.game.current_hand.pot
    self.game.current_hand.update(pot: pot + add_to_pot)
    return add_to_pot #return amount the play is actually allowed to bet
  end

end

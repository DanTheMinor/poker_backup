class Player < ActiveRecord::Base
  has_many :cards
  belongs_to :game

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

  def update_amounts(choice, amount)
    if choice == "bet"
      amount = update_chips(amount)
      game.current_hand.update(last_bet: amount)
    elsif choice == "raise"
      if amount > stack
        amount = stack - game.current_hand.last_bet
      end
      if game.other_player.choice == 'call' #when the small blind calls, dont consider the amount they called the last bet
        game.current_hand.update(last_bet: 0)
      end
      amount_raise = amount + game.current_hand.last_bet 
      game.current_hand.update(last_bet: amount)
      update_chips(amount_raise)
    elsif choice == "call"
      amount_called = game.current_hand.last_bet.to_i
      update_chips(amount_called)
    end
  end
end

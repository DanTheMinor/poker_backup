class Player < ActiveRecord::Base
  has_many :cards


  #methods for player class

  #need to know:  player, min/max bet, options, option chosen, pot amount

  #pre-flop, small blind methods

  def post_blinds(bb, sb) #automatically post blinds

  end

  def call(bet) #subtract from player stack bet amount
    #returns amount to add to pot
    add_to_pot = 0
    if self.stack < bet
      add_to_pot = self.stack()
      self.stack = 0
    else
      add_to_pot = bet
      self.stack -= bet
    end
    add_to_pot
  end

  def bet(bet) #subtracts from player stack bet amount
    #returns amount to add to pot
    add_to_pot = 0
    if self.stack < bet
      add_to_pot = self.stack
      self.stack = 0
    else
      add_to_pot = bet
      self.stack -= bet
    end
    add_to_pot
  end

  def is_bb? #if the player is bb, return true
    game = Game.find(self.game_id)
    if self == game.players[0]
      if self.game_id % 2 == 0
        true
      else
        false
      end
    else
      if self.game_id % 2 == 0
        false
      else
        true
      end
    end
  end

  # def won(amount) #gives the player who won the pot
  #
  # end

  def fold()

  end

end

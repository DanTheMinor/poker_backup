class Hand < ActiveRecord::Base
  has_many :cards
  belongs_to :game


  # def part_of_initialize --This is meant to be built into intialize method
  #   if game_id == even
  #     player1 = big blind
  #     player2 = small blind
  #   else
  #     player1 = small blind
  #     player2 = big blind
  #   end
  # end


  def flop_deal
    first_card = Card.where(player_id: nil).sample
    self.cards << first_card
    second_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << second_card
    third_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << third_card
  end

  def turn_deal
    turn_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << turn_card
  end

  def river_deal
    river_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << river_card
  end

  def best_hand(player)
    seven_cards = player.cards + self.cards
    five_card_subsets = seven_cards.combination(5).to_a
    best_hand = five_card_subsets.first
    five_card_subsets.each do |five_cards|
      if five_cards.compare_cards(best_hand) == five_cards
        best_hand = five_cards
      end
    end
    best_hand
  end

  def winner
    player1 = self.game.players[0]
    player2 = self.game.players[1]
    player1_hand = best_hand(player1)
    player2_hand = best_hand(player2)
    if player1_hand.compare_cards(player2_hand) == player1_hand
      player1.update(stack: player1.stack + self.pot)
      self.update(winner_id: player1.id())
      return player1
    elsif player1_hand.compare_cards(player2_hand) == player2_hand
      self.update(winner_id: player2.id())
      player2.update(stack: player2.stack + self.pot)
      #gives the winner the money in the pot
      return player2
    else
      player1.update(stack: player1.stack + self.pot/2)
      player2.update(stack: player2.stack + self.pot/2)
      return 'tie'
    end
  end

  def handle_choice(player, other_player) #changes the round based on player's choice
    #the player is whoever made the decision
    unless player.is_bb && player.choice == 'call' || self.current_round == 'preflop' && player.is_bb && player.choice == 'check'
      player.update(is_turn: false)
      other_player.update(is_turn: true)
    end
    if player.choice == 'call'
      if current_round != 'preflop'
        change_round()
      elsif player.is_bb == true
        change_round()
      elsif current_round == 'preflop' && other_player.choice == 'bet/raise'
        change_round()
      elsif other_player.stack == 0 || player.stack == 0
        change_round()
        self.update(current_round: 'game over')
      end
    elsif player.choice == 'fold'
      self.update(current_round: 'game over')
      other_player.update(stack: other_player.stack + self.pot()) #gives the winner the money in the pot
      self.update(winner_id: other_player.id())
    #there is no need for an if == raise because it will never change the round
    elsif player.choice == 'check'
      if player.is_bb == false || self.current_round == "preflop"
        change_round()
      end
    end
  end

  def current_choices(player, other_player) #returns an array of the current players choices
    #depedning on round,
    #the player is whoever your displaying choices for
    if self.is_all_in?
      self.deal_remaining
      self.winner
      return [] #no buttons as no choices are available
    elsif self.current_round == 'preflop'
      if player.is_bb == true
        if other_player.choice == 'call'
          return ["check", "bet/raise"]
        else
          return ["call", "fold", "bet/raise"]
        end
      else
        return ["call", "fold", "bet/raise"]
      end
    else
      if other_player.choice == "new round"
        return ["check", "bet/raise"]
      elsif other_player.choice == "check" && player.is_bb == false
        return ["check", "bet/raise"]
      else
        return ["call", "fold", "bet/raise"]
      end
    end
  end

  def change_round
    game = Game.find(self.game_id)

    game.players[0].update(choice: "new round")
    game.players[1].update(choice: "new round")
    if self.current_round == "preflop"
      self.flop_deal
      self.update(current_round: "flop")
    elsif self.current_round == 'flop'
      self.turn_deal
      self.update(current_round: "turn")
    elsif self.current_round == 'turn'
      self.river_deal
      self.update(current_round: "river")
    else
      self.winner
      self.update(current_round: "show cards")
    end
  end

  def is_over?
    player_wins? || is_tie?
  end

  def player_wins?
    self.winner_id != nil
  end

  def is_tie?
    self.winner_id == nil && self.current_round == "show cards"
  end

  def winning_player
    Player.find(winner_id)
  end

  def is_all_in?
    game = Game.find(self.game_id)
    player1 = game.players[0]
    player2 = game.players[1]
    if player1.stack == 0 && player2.choice == 'call'|| player2.stack == 0 && player1.choice == 'call'
      return true
    end
    return false
  end

  def deal_remaining
    if self.current_round == "preflop"
      self.flop_deal
      self.turn_deal
      self.river_deal
    elsif self.current_round == "flop"
      self.turn_deal
      self.river_deal
    elsif self.current_round == 'turn'
      self.river_deal
    else
      #do nothing
    end
  end

  def special_bet(bet_choice, player)
    #DO NOT CALL THIS METHOD IF THE PLAYER INOUT AMOUNT MANUALLY
    bet = 0
    if bet_choice == 'half pot'
      bet = (self.pot / 2)
    elsif bet_choice == 'pot'
      bet = self.pot
    else #CHOICE WAS ALL IN
      bet = player.stack()
    end
    return bet
  end


end

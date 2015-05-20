# require "compare_cards"

class Hand < ActiveRecord::Base
  has_many :cards
  belongs_to :game

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
      return player1
    elsif player1_hand.compare_cards(player2_hand) == player2_hand
      return player2
    else
      return 'tie'
    end
  end
end

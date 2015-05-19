class Hand < ActiveRecord::Base
  has_many :cards

  def flop_deal
    first_card = Card.where(player_id: nil).sample
    self.cards << first_card
    second_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << second_card
    third_card = Card.where(player_id: nil, hand_id: nil).sample
    self.cards << third_card
  end

end

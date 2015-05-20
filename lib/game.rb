class Game < ActiveRecord::Base
  has_many :players
  has_many :hands
  after_save(:populate_deck)

  @@suits = ["s","c","d","h"]
  @@values = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"]

  def populate_deck
    @@suits.each do |suit|
      @@values.each do |value|
        Card.create(suit: suit, value: value, url: suit + value + ".png")  #populate cards database
      end
    end
  end

  def deal(player)
    first_card = Card.where(player_id: nil).sample
    player.cards << first_card
    second_card = Card.where(player_id: nil).sample
    player.cards << second_card
  end

  def current_hand
    self.hands.last
  end

  def new_hand
    hands.create(pot: 0, current_round: "preflop")
    hand_count = hands.length
    if hand_count % 2 == 0
      players[0].update(is_bb: true)
      players[1].update(is_bb: false)
    else
      players[1].update(is_bb: true)
      players[0].update(is_bb: false)
    end
    Card.update_all(player_id: nil, hand_id: nil)
    players.each {|player| deal(player)}
  end


end

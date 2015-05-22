class Game < ActiveRecord::Base
  has_many :players
  has_many :hands
  after_save(:clear_tables)
  after_save(:populate_deck)

  @@suits = ["s","c","d","h"]
  @@values = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"]

  def clear_tables
    Card.delete_all
    Player.delete_all
    Hand.delete_all
  end

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
    hands.create(pot: 0, current_round: "preflop", last_bet: 1)
    hand_count = hands.length
    if players[0].is_bb == false
      players[0].update(is_bb: true, choice: "new round", is_turn: false)
      players[0].update_chips(2)
      players[1].update(is_bb: false, choice: "new round", is_turn: true)
      players[1].update_chips(1)
    else
      players[1].update(is_bb: true, choice: "new round", is_turn: false)
      players[1].update_chips(2)
      players[0].update(is_bb: false, choice: "new round", is_turn: true)
      players[0].update_chips(1)
    end
    Card.update_all(player_id: nil, hand_id: nil)
    players.each {|player| deal(player)}
  end

  def current_player
    players.select {|player| player.is_turn == true}.first
  end

  def other_player
    players.select {|player| player.is_turn == false}.first
  end
end

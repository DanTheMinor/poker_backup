class Game < ActiveRecord::Base
  has_many :players
  after_save(:populate_deck)

  @@suits = ["s","c","d","h"]
  @@values = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"]

  def populate_deck
    @@suits.each do |suit|
      @@values.each do |value|
        Card.create(suit: suit, value: value, url: value + suit + ".jpg")
      end
    end
  end

  def deal(player)
    dealt_card = Card.where(value: "2", suit: "s").first
    player.cards << dealt_card
  end

end

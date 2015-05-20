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
    first_card = Card.all.sample
    player.cards << first_card
    second_card = Card.where(player_id: nil).sample
    player.cards << second_card
  end

  def compare_cards(hand_1, hand_2)
    #hand_1 and hand_2 are arrays of five card objects
    #card objects contain a value and a face


    #for full house logic
    #compare the three cards for biggest for who wins
    #compare the two cards for biggest
    return #the best array of five cards
  end


end

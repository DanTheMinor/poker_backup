###module for comparing cards



  def best_hand do |hand| #hand is an array with 7 cards
      #loop
        #card_set1 = best
        #card_set2 = another_set
        #best = compare_cards(card_set1, card_set2)
      #end
      #return best
  end


  def compare_cards do |hand_1, hand_2|
    #hand_1 and hand_2 are arrays of five card objects
    #card objects contain a value and a face


    #for full house logic
      #compare the three cards for biggest for who wins
      #compare the two cards for biggest
      return #the best array of five cards

  end

  def winner do |hand_1, hand_2| #arrays of 7 cards
    #hand1 = best_hand(hand_1)
    #hand2 = best_hand(hand_2) #arrays of 5 cards
    #
    if hand1 == hand2
      return 3#for tie
    elsif hand1 ==  compare_cards(hand1, hand2)
      return 1#player 1 wins
    else
      return 2#player 2 wins
    end
  end



  def is_flush do |hand| #returns whether a particular hand is a flush
    suit = hand.card(1).suit()
    is_flush = true
    hand.each do |card|
        if suit != card.suit()
          is_flush == false
        end

    end
  end


  def is_straight do |hand| #returns whether a particular hand is a straight
    straight = hand.sort_cards()
    first = straight.at(0)
    index = 1
    is_straight = true
    do while index < straight.length
      if (first + 1) == straight.at(index)
        first = straight.at(index)
      else
        is_straight = false
      end
      index += 1
    end

    #special case for determing in its a wheel straight
    if straight.at(4) == 14
      if straight.at(0) == 2 && straight.at(1) == 3 && straight.at(2) == 4 && straight.at(3) == 5
        is_straight = true
      else
        is_straight = false
      end
    end

    return is_straight
  end

  def max_matches #returns if you have a pair, three of a kind or four of a kind and what the card value is
    #return [0, value] if no matches
    #return [2, value] if pair
    #return [3, value] if three ofa  kind
    #reutrn [4, value] if four of a kind
  end


  def is_full_house do |hand|
    full_house = hand.sort_cards()
      is_three? = true
      is_pair? = true
      find_three = hand.at(0)

  end

  def sort_cards do
    @card_sort = []
    self.cards().each() do |card|
      true_value = card.true_value()
      @card_sort.push(true_value)
    end
    @card_sort.sort!
  end




  def find_kick do |hand|

  end

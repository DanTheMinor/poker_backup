  ###module for comparing cards
module CompareCards
  # hand_types = {
  #   "straight flush" => [is_straight_flush, compare_straight_flush],
  #   "straight" => [is_straight, compare_straight],
  #   "flush" => [is_flush, compare_flush],
  #   "fullhouse" => [is_full_house, compare_full_house],
  #   "four of a kind" => [is_four_kind, compare_four_of_a_kind],
  #   "three of a kind" => [is_three_kind, compare_three_of_a_kind],
  #   "one pair" => [is_one_pair, compare_one_pair],
  #   "two pair" => [is_two_pair, compare_two_pair],
  #   "high card" => [is_high_card, compare_high_card]
  # }
  #
  #
  #   def compare_cards(hand_1, hand_2)
  #
  #     ["straight flush",...,"one pair", "high card"].each do |type|
  #       is_type? = hand_types.fetch(type)[0]
  #       compare_type = hand_types.fetch(type)[1]
  #       if hand_1.is_type? && hand_2.is_type?
  #         return hand1.compare_type(hand_2)
  #       elsif hand_1.is_type?
  #         return hand_1
  #       elsif hand_2.is_type?
  #         return hand_2
  #       end
  #     end
  #   end

    def compare_values(other_hand)
      true_value1 = 0
      true_value2 = 0

      self.each do |card|
        true_value1 += card.true_value
      end
      other_hand.each do |card|
        true_value2 += card.true_value
      end

      if true_value1 > true_value2
        return self
      elsif true_value1 < true_value2
        return other_hand
      else
        return "tie"
      end
    end

    def compare_flush(other_hand)
      self.compare_values(other_hand)
    end

    def compare_straight(other_hand)
        #will not work for wheels!

        self.compare_values(other_hand)
    end

    def compare_straight_flush(other_hand)
      #will not work for wheels!

      self.compare_values(other_hand)
    end

    def compare_three_kind(other_hand)
      self_values = self.map {|card| card.true_value}
      three_kind_value1 = self_values.select {|value| self_values.count(value) == 3}.first
      other_hand_values = other_hand.map {|card| card.true_value}
      three_kind_value2 = other_hand_values.select {|value| other_hand_values.count(value) == 3}.first

      if three_kind_value1 > three_kind_value2
        return self
      else
        return other_hand
      end
    end

    def compare_full_house(other_hand)
      self.compare_three_kind(other_hand)
    end

    def compare_high_card(other_hand)
      self_values = self.map {|card| card.true_value}.sort.reverse
      other_hand_values = other_hand.map {|card| card.true_value}.sort.reverse
      value_pairs = self_values.zip(other_hand_values)
      value_pairs.each do |pair|
        if pair[0] > pair[1]
          return self
        elsif pair[1] > pair[0]
          return other_hand
        end
      end
      'tie'
    end

    def compare_two_pair(other_hand)

    end


    def what_type
      hand = self
      type = ""
      if hand.is_straight && hand.is_flush
        type = "straight flush"
      elsif hand.is_four_kind
        type = "four of a kind"
      elsif hand.is_full_house
        type = "full house"
      elsif hand.is_flush
        type = "flush"
      elsif hand.is_straight
        type = "straight"
      elsif hand.is_three_kind
        type = "three of a kind"
      elsif hand.is_two_pair
        type = "two pair"
      elsif hand.is_pair
        type = "pair"
      else
        type = "high card"
      end
    end
    #sort method that orders by greatest number of a card first(for full houses and two pairs)
    #sort by value
    #check which value is first

    def is_flush #returns whether a particular hand is a flush
      hand = self
      suit = hand.at(0).suit()
      is_flush = true
      hand.each do |card|
        if suit != card.suit()
          is_flush = false
        end

      end
      is_flush
    end


    def is_straight #returns whether a particular hand is a straight
      hand = self
      straight = hand.sort_cards()
      first = straight.at(0)
      index = 1
      is_straight = true
      while index < straight.length
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


    def is_full_house
      hand = self
      fullhouse = hand.sort_cards()
      is_full_house = true
      if fullhouse.at(0) == fullhouse.at(1) && fullhouse.at(0) == fullhouse.at(2) && fullhouse.at(3) == fullhouse.at(4)
        is_full_house = true
      elsif fullhouse.at(2) == fullhouse.at(3) && fullhouse.at(2) == fullhouse.at(4) && fullhouse.at(0) == fullhouse.at(1)
        is_full_house = true
      else
        is_full_house = false
      end
      is_full_house
    end

    def is_four_kind
      hand = self
      fourkind = hand.sort_cards()
      is_four = true
      if fourkind.count(fourkind.at(0)) == 4 || fourkind.count(fourkind.at(1)) == 4
        is_four = true
      else
        is_four = false
      end
      is_four
    end

    def is_three_kind
      hand = self
      threekind = hand.sort_cards()
      is_three = true
      if threekind.count(threekind.at(0)) == 3 || threekind.count(threekind.at(1)) == 3 || threekind.count(threekind.at(2)) == 3
        is_three = true
      else
        is_three = false
      end
      is_three
    end

    def is_two_pair
      hand = self
      twopair = hand.sort_cards()
      is_twopair = true
      if twopair.count(twopair.at(0)) == 2 && twopair.count(twopair.at(2)) == 2 || twopair.count(twopair.at(0)) == 2 && twopair.count(twopair.at(3)) == 2 || twopair.count(twopair.at(1)) == 2 && twopair.count(twopair.at(3)) == 2
        is_twopair = true
      else
        is_twopair = false
      end
    end

    def is_pair
      hand = self
      pair = hand.sort_cards()
      is_pair = true
      pair_check = []
      pair.each() do |card|
        if pair.count(card) == 2
          pair_check.push(card)
        end
      end
      if pair_check.length == 2
        is_pair = true
      else
        is_pair = false
      end
      is_pair
    end

        
    def sort_cards
      @card_sort = []
      self.each() do |card|
        true_value = card.true_value()
        @card_sort.push(true_value)
      end
      @card_sort.sort!
    end


end

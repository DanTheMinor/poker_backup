class Array

    def compare_cards(other_hand)
      [:is_straight_flush,:is_four_kind, :is_full_house,:is_flush,
      :is_straight, :is_three_kind, :is_two_pair, :is_pair].each do |is_type|
        if self.send(is_type) && other_hand.send(is_type)
          return self.compare_same_type(other_hand)
        elsif self.send(is_type)
          return self
        elsif other_hand.send(is_type)
          return other_hand
        end
      end
      return self.compare_same_type(other_hand)
    end

    def select_by_count(n)
      # selects all values of a certain count
      self.select {|value| self.count(value) == n}.uniq.sort.reverse
    end

    def sorted_distinct_values
      #sorts card values by bringing cards with higher repetition to the front of the array
      #e.g. 23232 would become 23
      #for cards with same repetition, prioritizes value next
      #e.g. 89797 becomes 978
      values = self.map {|card| card.true_value}
      sorted_values = []
      [4,3,2,1].each {|n| sorted_values += values.select_by_count(n)}
      sorted_values
    end

    def is_wheel?
      self == ['14', '5', '4', '3', '2']
    end

    def compare_same_type(other_hand)
      #first sorts the two hands values to put them in the right form
      #for value by value comparison
      self_values = self.sorted_distinct_values
      other_values = other_hand.sorted_distinct_values

      #check for wheels first
      if self_values.is_wheel? && other_values.is_wheel?
        return 'tie'
      elsif self_values.is_wheel?
        return other_hand
      elsif other_values.is_wheel?
        return self
      end

      #compare the values
      value_pairs = self_values.zip(other_values)
      value_pairs.each do |pair|
        if pair[0] > pair[1]
          return self
        elsif pair[1] > pair[0]
          return other_hand
        end
      end
      'tie'
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

    def is_straight_flush
      self.is_flush && self.is_straight
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

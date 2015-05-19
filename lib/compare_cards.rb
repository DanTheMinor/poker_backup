  ###module for comparing cards
module CompareCards
  # hand_types = {
  #   "straight flush" => [is_straight_flush, compare_straight_flush],
  #   "straight" => [is_straight, compare_straight],
  #   "flush" => [is_flush, compare_flush],
  #   "fullhouse" => [is_full_house, compare_full_house],
  #   "four of a kind" => [is_four_of_a_kind, compare_four_of_a_kind],
  #   "three of a kind" => [is_three_of_a_kind, compare_three_of_a_kind],
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
end

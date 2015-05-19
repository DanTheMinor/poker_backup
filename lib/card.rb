class Card < ActiveRecord::Base
  belongs_to :player

  def true_value
    true_value = nil
    if self.value == "j"
      true_value = 11
    elsif self.value == "q"
      true_value = 12
    elsif self.value == "k"
      true_value = 13
    elsif self.value == "a"
      true_value = 14
    else
      true_value = self.value.to_i
    end
    true_value
  end
end

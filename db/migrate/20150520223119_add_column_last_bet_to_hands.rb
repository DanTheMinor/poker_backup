class AddColumnLastBetToHands < ActiveRecord::Migration
  def change
    add_column(:hands, :last_bet, :integer)
  end
end

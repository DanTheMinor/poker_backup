class AddWinnerIdToHands < ActiveRecord::Migration
  def change
    add_column(:hands, :winner_id, :integer)
  end
end

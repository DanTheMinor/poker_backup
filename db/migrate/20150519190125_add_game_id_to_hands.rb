class AddGameIdToHands < ActiveRecord::Migration
  def change
    add_column(:hands, :game_id, :integer)
  end
end

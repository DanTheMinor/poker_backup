class InsertGameId < ActiveRecord::Migration
  def change
    add_column(:players, :game_id, :int)
  end
end

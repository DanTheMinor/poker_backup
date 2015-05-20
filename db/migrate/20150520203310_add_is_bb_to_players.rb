class AddIsBbToPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :is_bb, :binary)
  end
end

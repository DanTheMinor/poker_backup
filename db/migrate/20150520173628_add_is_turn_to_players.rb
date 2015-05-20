class AddIsTurnToPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :is_turn, :binary)
  end
end

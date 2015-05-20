class AddPlayerChoiceToPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :player_choice, :string)
  end
end

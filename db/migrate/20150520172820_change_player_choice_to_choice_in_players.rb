class ChangePlayerChoiceToChoiceInPlayers < ActiveRecord::Migration
  def change
    remove_column(:players, :player_choice)
    add_column(:players, :choice, :string)
  end
end

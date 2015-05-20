class AddStackToPlayers < ActiveRecord::Migration
  def change
    add_column(:players, :stack, :integer)
  end
end

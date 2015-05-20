class EditColumn < ActiveRecord::Migration
  def change
    remove_column(:players, :is_turn)
    remove_column(:players, :is_bb)
    add_column(:players, :is_turn, :boolean)
    add_column(:players, :is_bb, :boolean)
  end
end

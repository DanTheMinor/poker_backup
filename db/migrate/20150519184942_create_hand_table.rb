class CreateHandTable < ActiveRecord::Migration
  def change
    create_table (:hands) do |t|
      t.integer :pot
      t.string :current_round
    end
    add_column(:cards, :hand_id, :integer)
  end
end

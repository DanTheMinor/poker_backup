class CreateTableCards < ActiveRecord::Migration
  def change
    create_table(:cards) do |t|
      t.column(:suit, :string)
      t.column(:value, :string)
      t.column(:url, :string)

      t.timestamps
    end
  end
end

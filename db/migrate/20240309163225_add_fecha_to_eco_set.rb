class AddFechaToEcoSet < ActiveRecord::Migration[5.2]
  def change
    add_column :eco_sets, :fecha, :date
    add_index :eco_sets, :fecha
  end
end

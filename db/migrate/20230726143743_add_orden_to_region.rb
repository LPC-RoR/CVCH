class AddOrdenToRegion < ActiveRecord::Migration[5.2]
  def change
    add_column :regiones, :orden, :integer
    add_index :regiones, :orden
  end
end

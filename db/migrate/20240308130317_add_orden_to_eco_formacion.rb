class AddOrdenToEcoFormacion < ActiveRecord::Migration[5.2]
  def change
    add_column :eco_formaciones, :orden, :integer
    add_index :eco_formaciones, :orden
  end
end

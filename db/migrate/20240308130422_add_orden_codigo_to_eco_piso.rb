class AddOrdenCodigoToEcoPiso < ActiveRecord::Migration[5.2]
  def change
    add_column :eco_pisos, :orden, :integer
    add_index :eco_pisos, :orden
    add_column :eco_pisos, :codigo, :string
    add_index :eco_pisos, :codigo
  end
end

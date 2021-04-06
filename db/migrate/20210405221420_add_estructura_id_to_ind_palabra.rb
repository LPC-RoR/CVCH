class AddEstructuraIdToIndPalabra < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_palabras, :ind_estructura_id, :integer
    add_index :ind_palabras, :ind_estructura_id
  end
end

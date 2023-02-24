class AddIndSinonimoIdToIndPalabra < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_palabras, :ind_sinonimo_id, :integer
    add_index :ind_palabras, :ind_sinonimo_id
  end
end

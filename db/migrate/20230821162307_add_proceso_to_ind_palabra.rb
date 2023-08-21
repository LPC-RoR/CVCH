class AddProcesoToIndPalabra < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_palabras, :proceso, :string
    add_index :ind_palabras, :proceso
  end
end

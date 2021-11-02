class AddPortadaToHPortada < ActiveRecord::Migration[5.2]
  def change
    add_column :h_portadas, :portada, :string
    remove_column :h_portadas, :imagen, :string
    remove_column :h_portadas, :credito_imagen, :string
    
    add_index :h_portadas, :portada
  end
end

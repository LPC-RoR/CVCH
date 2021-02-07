class AddPerfilIdToRuta < ActiveRecord::Migration[5.2]
  def change
    add_column :rutas, :perfil_id, :integer
    add_index :rutas, :perfil_id
  end
end

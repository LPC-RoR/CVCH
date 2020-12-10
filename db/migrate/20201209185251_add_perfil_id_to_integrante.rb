class AddPerfilIdToIntegrante < ActiveRecord::Migration[5.2]
  def change
    add_column :integrantes, :perfil_id, :integer
    add_index :integrantes, :perfil_id
  end
end

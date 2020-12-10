class AddPerfilIdToEquipo < ActiveRecord::Migration[5.2]
  def change
    add_column :equipos, :perfil_id, :integer
    add_index :equipos, :perfil_id
  end
end

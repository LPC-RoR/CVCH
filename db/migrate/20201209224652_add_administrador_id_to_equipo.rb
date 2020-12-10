class AddAdministradorIdToEquipo < ActiveRecord::Migration[5.2]
  def change
    add_column :equipos, :administrador_id, :integer
    add_index :equipos, :administrador_id

    remove_column :equipos, :perfil_id, :string
  end
end

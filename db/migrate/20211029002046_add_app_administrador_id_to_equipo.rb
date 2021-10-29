class AddAppAdministradorIdToEquipo < ActiveRecord::Migration[5.2]
  def change
    add_column :equipos, :app_administrador_id, :integer
    add_index :equipos, :app_administrador_id
  end
end

class RenameAppAdministradorIdFromAppPerfil < ActiveRecord::Migration[5.2]
  def change
  	rename_column :app_perfiles, 'administrador_id', 'app_administrador_id'
  end
end

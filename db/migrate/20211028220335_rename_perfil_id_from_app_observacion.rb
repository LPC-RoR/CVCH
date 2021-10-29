class RenamePerfilIdFromAppObservacion < ActiveRecord::Migration[5.2]
  def change
  	rename_column :app_observaciones, 'perfil_id', 'app_perfil_id'
  end
end

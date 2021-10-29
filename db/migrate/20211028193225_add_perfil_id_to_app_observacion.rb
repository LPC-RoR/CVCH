class AddPerfilIdToAppObservacion < ActiveRecord::Migration[5.2]
  def change
    add_column :app_observaciones, :perfil_id, :integer
    add_index :app_observaciones, :perfil_id
  end
end

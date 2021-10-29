class AddAppPerfilIdToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :app_perfil_id, :integer
    add_index :publicaciones, :app_perfil_id
  end
end

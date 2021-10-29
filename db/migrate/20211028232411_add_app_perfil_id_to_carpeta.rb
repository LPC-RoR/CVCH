class AddAppPerfilIdToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :app_perfil_id, :integer
    add_index :carpetas, :app_perfil_id
  end
end

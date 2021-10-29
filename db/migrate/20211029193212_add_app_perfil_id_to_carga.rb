class AddAppPerfilIdToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :app_perfil_id, :integer
    add_index :cargas, :app_perfil_id
  end
end

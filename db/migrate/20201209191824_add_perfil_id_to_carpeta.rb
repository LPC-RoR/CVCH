class AddPerfilIdToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :perfil_id, :integer
    add_index :carpetas, :perfil_id
    remove_column :carpetas, :investigador_id, :string
  end
end

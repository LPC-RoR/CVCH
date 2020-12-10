class AddPerfilIdToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :perfil_id, :integer
    add_index :cargas, :perfil_id

    remove_column :cargas, :investigador_id, :string
  end
end

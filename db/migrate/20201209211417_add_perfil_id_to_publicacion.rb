class AddPerfilIdToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :perfil_id, :integer
    add_index :publicaciones, :perfil_id

    remove_column :publicaciones, :investigador_id, :string
  end
end

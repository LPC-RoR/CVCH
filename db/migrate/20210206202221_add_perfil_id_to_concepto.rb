class AddPerfilIdToConcepto < ActiveRecord::Migration[5.2]
  def change
    add_column :conceptos, :perfil_id, :integer
    add_index :conceptos, :perfil_id
    add_column :conceptos, :administracion, :boolean
    add_index :conceptos, :administracion
  end
end

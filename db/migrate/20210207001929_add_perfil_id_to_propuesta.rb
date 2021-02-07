class AddPerfilIdToPropuesta < ActiveRecord::Migration[5.2]
  def change
    add_column :propuestas, :perfil_id, :integer
    add_index :propuestas, :perfil_id
  end
end

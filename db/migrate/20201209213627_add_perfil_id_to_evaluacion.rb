class AddPerfilIdToEvaluacion < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluaciones, :perfil_id, :integer
    add_index :evaluaciones, :perfil_id

    remove_column :evaluaciones, :investigador_id, :string
  end
end

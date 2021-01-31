class RemoveEquipoIdFromPublicacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :publicaciones, :equipo_id, :integer
  end
end

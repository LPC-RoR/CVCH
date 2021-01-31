class RemoveEquipoIdFromCarpeta < ActiveRecord::Migration[5.2]
  def change
    remove_column :carpetas, :equipo_id, :integer
  end
end

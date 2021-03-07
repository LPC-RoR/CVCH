class AddRevisadoToEtiqueta < ActiveRecord::Migration[5.2]
  def change
    add_column :etiquetas, :revisado, :boolean
    add_column :etiquetas, :asociado_por, :integer
  end
end

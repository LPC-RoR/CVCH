class AddCamposToFiloActualizacion < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_actualizaciones, :link_fuente, :string
    add_column :filo_actualizaciones, :sinonimia, :text
  end
end

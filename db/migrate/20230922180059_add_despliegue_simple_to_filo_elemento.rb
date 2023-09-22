class AddDespliegueSimpleToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :despliegue_simple, :boolean
  end
end

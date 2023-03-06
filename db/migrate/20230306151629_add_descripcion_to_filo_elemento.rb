class AddDescripcionToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :descripcion, :string
  end
end

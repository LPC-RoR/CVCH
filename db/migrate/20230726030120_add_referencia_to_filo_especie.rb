class AddReferenciaToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :referencia, :string
  end
end

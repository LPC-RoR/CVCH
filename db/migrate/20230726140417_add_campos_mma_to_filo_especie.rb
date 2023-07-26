class AddCamposMmaToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :filo_categoria_conservacion_id, :integer
    add_index :filo_especies, :filo_categoria_conservacion_id
  end
end

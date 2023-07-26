class AddFiloTipoEspecieIdToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :filo_tipo_especie_id, :integer
    add_index :filo_especies, :filo_tipo_especie_id
  end
end

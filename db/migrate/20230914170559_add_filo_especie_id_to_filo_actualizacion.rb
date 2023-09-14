class AddFiloEspecieIdToFiloActualizacion < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_actualizaciones, :filo_especie_id, :integer
    add_index :filo_actualizaciones, :filo_especie_id
  end
end

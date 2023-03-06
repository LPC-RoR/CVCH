class AddFiloEspecieIdToEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :especies, :filo_especie_id, :integer
    add_index :especies, :filo_especie_id
  end
end

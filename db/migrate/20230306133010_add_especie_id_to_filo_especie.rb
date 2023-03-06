class AddEspecieIdToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :especie_id, :integer
    add_index :filo_especies, :especie_id
  end
end

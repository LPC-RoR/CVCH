class AddFiloEspecieIdToFiloCriterio < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_criterios, :filo_especie_id, :integer
    add_index :filo_criterios, :filo_especie_id
  end
end

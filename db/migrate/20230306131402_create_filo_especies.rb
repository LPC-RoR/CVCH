class CreateFiloEspecies < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_especies do |t|
      t.string :filo_especie
      t.string :nombre_comun
      t.string :iucn
      t.integer :filo_elemento_id

      t.timestamps
    end
    add_index :filo_especies, :filo_especie
    add_index :filo_especies, :filo_elemento_id
  end
end

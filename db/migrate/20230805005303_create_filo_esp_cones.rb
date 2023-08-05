class CreateFiloEspCones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_esp_cones do |t|
      t.integer :filo_especie_id
      t.integer :filo_categoria_conservacion_id

      t.timestamps
    end
    add_index :filo_esp_cones, :filo_especie_id
    add_index :filo_esp_cones, :filo_categoria_conservacion_id
  end
end

class CreateFiloEspTipos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_esp_tipos do |t|
      t.integer :filo_especie_id
      t.integer :filo_tipo_especie_id

      t.timestamps
    end
    add_index :filo_esp_tipos, :filo_especie_id
    add_index :filo_esp_tipos, :filo_tipo_especie_id
  end
end

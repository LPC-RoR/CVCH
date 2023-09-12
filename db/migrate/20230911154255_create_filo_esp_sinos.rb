class CreateFiloEspSinos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_esp_sinos do |t|
      t.integer :filo_especie_id
      t.integer :filo_sinonimo_id

      t.timestamps
    end
    add_index :filo_esp_sinos, :filo_especie_id
    add_index :filo_esp_sinos, :filo_sinonimo_id
  end
end

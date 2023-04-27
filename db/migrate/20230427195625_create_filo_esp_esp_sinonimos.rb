class CreateFiloEspEspSinonimos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_esp_esp_sinonimos do |t|
      t.integer :especie_id
      t.integer :sinonimo_id

      t.timestamps
    end
    add_index :filo_esp_esp_sinonimos, :especie_id
    add_index :filo_esp_esp_sinonimos, :sinonimo_id
  end
end

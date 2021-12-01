class CreateEspAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :esp_areas do |t|
      t.integer :especie_id
      t.integer :area_id

      t.timestamps
    end
    add_index :esp_areas, :especie_id
    add_index :esp_areas, :area_id
  end
end

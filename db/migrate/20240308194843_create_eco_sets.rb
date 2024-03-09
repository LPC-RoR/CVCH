class CreateEcoSets < ActiveRecord::Migration[5.2]
  def change
    create_table :eco_sets do |t|
      t.integer :eco_lugar_id
      t.integer :publicacion_id
      t.string :annio
      t.string :coordenadas

      t.timestamps
    end
    add_index :eco_sets, :eco_lugar_id
    add_index :eco_sets, :publicacion_id
  end
end

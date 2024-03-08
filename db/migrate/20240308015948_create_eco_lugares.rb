class CreateEcoLugares < ActiveRecord::Migration[5.2]
  def change
    create_table :eco_lugares do |t|
      t.string :eco_lugar
      t.integer :region_id
      t.string :coordenadas

      t.timestamps
    end
    add_index :eco_lugares, :eco_lugar
    add_index :eco_lugares, :region_id
  end
end

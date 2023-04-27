class CreateCarFiloEsps < ActiveRecord::Migration[5.2]
  def change
    create_table :car_filo_esps do |t|
      t.integer :carpeta_id
      t.integer :filo_especie_id

      t.timestamps
    end
    add_index :car_filo_esps, :carpeta_id
    add_index :car_filo_esps, :filo_especie_id
  end
end

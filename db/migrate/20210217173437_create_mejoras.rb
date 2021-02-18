class CreateMejoras < ActiveRecord::Migration[5.2]
  def change
    create_table :mejoras do |t|
      t.string :mejora
      t.text :detalle
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :mejoras, :publicacion_id
  end
end

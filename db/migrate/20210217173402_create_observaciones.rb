class CreateObservaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :observaciones do |t|
      t.string :observacion
      t.text :detalle
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :observaciones, :publicacion_id
  end
end

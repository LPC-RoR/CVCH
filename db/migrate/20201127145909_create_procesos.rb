class CreateProcesos < ActiveRecord::Migration[5.2]
  def change
    create_table :procesos do |t|
      t.integer :carga_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :procesos, :carga_id
    add_index :procesos, :publicacion_id
  end
end

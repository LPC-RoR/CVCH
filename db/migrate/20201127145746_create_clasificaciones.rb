class CreateClasificaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :clasificaciones do |t|
      t.integer :carpeta_id
      t.integer :publicacion_id
      t.integer :coleccion_id
      t.integer :paper_id

      t.timestamps
    end
    add_index :clasificaciones, :carpeta_id
    add_index :clasificaciones, :publicacion_id
    add_index :clasificaciones, :coleccion_id
    add_index :clasificaciones, :paper_id
  end
end

class CreateEtiquetas < ActiveRecord::Migration[5.2]
  def change
    create_table :etiquetas do |t|
      t.integer :categoria_id
      t.integer :publicacion_id
      t.integer :especie_id

      t.timestamps
    end
    add_index :etiquetas, :categoria_id
    add_index :etiquetas, :publicacion_id
    add_index :etiquetas, :especie_id
  end
end

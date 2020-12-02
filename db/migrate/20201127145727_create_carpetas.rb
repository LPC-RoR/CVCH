class CreateCarpetas < ActiveRecord::Migration[5.2]
  def change
    create_table :carpetas do |t|
      t.string :carpeta
      t.integer :investigador_id
      t.integer :equipo_id

      t.timestamps
    end
    add_index :carpetas, :carpeta
    add_index :carpetas, :investigador_id
    add_index :carpetas, :equipo_id
  end
end

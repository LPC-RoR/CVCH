class CreateHerencias < ActiveRecord::Migration[5.2]
  def change
    create_table :herencias do |t|
      t.integer :equipo_id
      t.integer :carpeta_id

      t.timestamps
    end
    add_index :herencias, :equipo_id
    add_index :herencias, :carpeta_id
  end
end

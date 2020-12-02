class CreateAutores < ActiveRecord::Migration[5.2]
  def change
    create_table :autores do |t|
      t.integer :investigador_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :autores, :investigador_id
    add_index :autores, :publicacion_id
  end
end

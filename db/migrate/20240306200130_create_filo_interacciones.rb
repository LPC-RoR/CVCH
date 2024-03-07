class CreateFiloInteracciones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_interacciones do |t|
      t.integer :filo_def_interaccion_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :filo_interacciones, :filo_def_interaccion_id
    add_index :filo_interacciones, :publicacion_id
  end
end

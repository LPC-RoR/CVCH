class CreateRutas < ActiveRecord::Migration[5.2]
  def change
    create_table :rutas do |t|
      t.integer :instancia_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :rutas, :instancia_id
    add_index :rutas, :publicacion_id
  end
end

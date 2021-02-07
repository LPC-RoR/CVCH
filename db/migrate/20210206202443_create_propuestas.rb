class CreatePropuestas < ActiveRecord::Migration[5.2]
  def change
    create_table :propuestas do |t|
      t.integer :instancia_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :propuestas, :instancia_id
    add_index :propuestas, :publicacion_id
  end
end

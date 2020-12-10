class CreatePerfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :perfiles do |t|
      t.integer :usuario_id
      t.integer :administrador_id
      t.integer :investigador_id
      t.integer :equipo_id

      t.timestamps
    end
    add_index :perfiles, :usuario_id
    add_index :perfiles, :administrador_id
    add_index :perfiles, :investigador_id
    add_index :perfiles, :equipo_id
  end
end

class CreatePerEquipos < ActiveRecord::Migration[5.2]
  def change
    create_table :per_equipos do |t|
      t.integer :app_perfil_id
      t.integer :equipo_id

      t.timestamps
    end
    add_index :per_equipos, :app_perfil_id
    add_index :per_equipos, :equipo_id
  end
end

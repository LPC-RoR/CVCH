class CreateFiloDefRolInteracciones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_def_rol_interacciones do |t|
      t.integer :filo_def_rol_id
      t.integer :filo_def_interaccion_id

      t.timestamps
    end
    add_index :filo_def_rol_interacciones, :filo_def_rol_id
    add_index :filo_def_rol_interacciones, :filo_def_interaccion_id
  end
end

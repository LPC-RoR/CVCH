class CreateFiloRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_roles do |t|
      t.string :filo_rol
      t.integer :filo_especie_id
      t.integer :filo_interaccion_id

      t.timestamps
    end
    add_index :filo_roles, :filo_rol
    add_index :filo_roles, :filo_especie_id
  end
end

class CreateFiloDefRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_def_roles do |t|
      t.string :filo_def_rol

      t.timestamps
    end
    add_index :filo_def_roles, :filo_def_rol
  end
end

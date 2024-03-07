class AddOrdenToFiloDefRol < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_def_rol_interacciones, :orden, :integer
    add_index :filo_def_rol_interacciones, :orden
  end
end

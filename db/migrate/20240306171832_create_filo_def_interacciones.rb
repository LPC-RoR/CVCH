class CreateFiloDefInteracciones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_def_interacciones do |t|
      t.string :filo_def_interaccion

      t.timestamps
    end
    add_index :filo_def_interacciones, :filo_def_interaccion
  end
end

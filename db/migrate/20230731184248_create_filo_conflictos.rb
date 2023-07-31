class CreateFiloConflictos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_conflictos do |t|
      t.integer :app_perfil_id
      t.string :filo_conflicto
      t.text :detalle
      t.boolean :resuelto

      t.timestamps
    end
    add_index :filo_conflictos, :app_perfil_id
  end
end

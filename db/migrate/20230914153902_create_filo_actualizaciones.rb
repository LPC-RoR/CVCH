class CreateFiloActualizaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_actualizaciones do |t|
      t.integer :app_perfil_id
      t.integer :filo_fuente_id
      t.string :referencia
      t.string :nombre_comun
      t.text :link_fuentesinonimia

      t.timestamps
    end
    add_index :filo_actualizaciones, :app_perfil_id
    add_index :filo_actualizaciones, :filo_fuente_id
  end
end

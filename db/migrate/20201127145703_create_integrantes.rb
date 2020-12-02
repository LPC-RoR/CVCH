class CreateIntegrantes < ActiveRecord::Migration[5.2]
  def change
    create_table :integrantes do |t|
      t.integer :investigador_id
      t.integer :equipo_id

      t.timestamps
    end
    add_index :integrantes, :investigador_id
    add_index :integrantes, :equipo_id
  end
end

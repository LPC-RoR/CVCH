class CreateDepartamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :departamentos do |t|
      t.string :departamento
      t.integer :institucion_id

      t.timestamps
    end
    add_index :departamentos, :institucion_id
  end
end

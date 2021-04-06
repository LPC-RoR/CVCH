class CreateIndModelos < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_modelos do |t|
      t.string :ind_modelo
      t.string :campos
      t.integer :ind_estructura_id

      t.timestamps
    end
    add_index :ind_modelos, :ind_estructura_id
  end
end

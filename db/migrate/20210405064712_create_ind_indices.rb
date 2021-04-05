class CreateIndIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_indices do |t|
      t.integer :ind_clave_id
      t.string :class_name
      t.integer :objeto_id

      t.timestamps
    end
    add_index :ind_indices, :ind_clave_id
    add_index :ind_indices, :class_name
    add_index :ind_indices, :objeto_id
  end
end

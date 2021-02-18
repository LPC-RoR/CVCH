class CreateRelaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :relaciones do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :relaciones, :parent_id
    add_index :relaciones, :child_id
  end
end

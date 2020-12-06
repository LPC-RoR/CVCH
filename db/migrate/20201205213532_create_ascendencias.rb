class CreateAscendencias < ActiveRecord::Migration[5.2]
  def change
    create_table :ascendencias do |t|
      t.integer :padre_id
      t.integer :hijo_id

      t.timestamps
    end
    add_index :ascendencias, :padre_id
    add_index :ascendencias, :hijo_id
  end
end

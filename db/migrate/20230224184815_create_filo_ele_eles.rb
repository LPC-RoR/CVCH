class CreateFiloEleEles < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_ele_eles do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :filo_ele_eles, :parent_id
    add_index :filo_ele_eles, :child_id
  end
end

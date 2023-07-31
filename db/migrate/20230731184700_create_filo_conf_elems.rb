class CreateFiloConfElems < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_conf_elems do |t|
      t.integer :filo_conflicto_id
      t.string :filo_elem_class
      t.integer :filo_elem_id

      t.timestamps
    end
    add_index :filo_conf_elems, :filo_conflicto_id
    add_index :filo_conf_elems, :filo_elem_id
  end
end

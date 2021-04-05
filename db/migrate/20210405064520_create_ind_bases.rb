class CreateIndBases < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_bases do |t|
      t.integer :clave_id
      t.integer :ind_palabra_id

      t.timestamps
    end
    add_index :ind_bases, :clave_id
    add_index :ind_bases, :ind_palabra_id
  end
end

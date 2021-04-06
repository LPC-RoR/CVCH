class CreateIndRedacciones < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_redacciones do |t|
      t.integer :ind_palabra_id
      t.integer :ind_expresion_id

      t.timestamps
    end
    add_index :ind_redacciones, :ind_palabra_id
    add_index :ind_redacciones, :ind_expresion_id
  end
end

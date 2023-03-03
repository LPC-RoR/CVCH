class CreateIndExpPales < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_exp_pales do |t|
      t.integer :ind_expresion_id
      t.integer :ind_palabra_id

      t.timestamps
    end
    add_index :ind_exp_pales, :ind_expresion_id
    add_index :ind_exp_pales, :ind_palabra_id
  end
end

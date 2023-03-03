class CreateIndIdeExps < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_ide_exps do |t|
      t.integer :ind_idea_id
      t.integer :ind_expresion_id

      t.timestamps
    end
    add_index :ind_ide_exps, :ind_idea_id
    add_index :ind_ide_exps, :ind_expresion_id
  end
end

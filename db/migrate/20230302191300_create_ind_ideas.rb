class CreateIndIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_ideas do |t|
      t.integer :ind_estructura_id
      t.string :ind_idea

      t.timestamps
    end
    add_index :ind_ideas, :ind_estructura_id
    add_index :ind_ideas, :ind_idea
  end
end

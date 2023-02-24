class CreateIndSets < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_sets do |t|
      t.string :ind_set
      t.string :tipo
      t.text :set

      t.timestamps
    end
    add_index :ind_sets, :ind_set
    add_index :ind_sets, :tipo
  end
end

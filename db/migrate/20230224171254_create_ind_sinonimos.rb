class CreateIndSinonimos < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_sinonimos do |t|
      t.string :ind_sinonimo

      t.timestamps
    end
    add_index :ind_sinonimos, :ind_sinonimo
  end
end

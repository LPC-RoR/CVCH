class AddIndPalabraIdToIndIndice < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_indices, :ind_palabra_id, :integer
    add_index :ind_indices, :ind_palabra_id
  end
end

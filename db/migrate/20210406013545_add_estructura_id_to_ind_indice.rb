class AddEstructuraIdToIndIndice < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_indices, :ind_estructura_id, :integer
    add_index :ind_indices, :ind_estructura_id
  end
end

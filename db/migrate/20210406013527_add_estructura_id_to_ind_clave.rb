class AddEstructuraIdToIndClave < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_claves, :ind_estructura_id, :integer
    add_index :ind_claves, :ind_estructura_id
  end
end

class AddEcoSetIdToFiloInteraccion < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_interacciones, :eco_set_id, :integer
    add_index :filo_interacciones, :eco_set_id
  end
end

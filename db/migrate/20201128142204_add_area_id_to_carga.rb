class AddAreaIdToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :area_id, :integer
    add_index :cargas, :area_id
  end
end

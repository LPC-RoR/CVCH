class AddAreaIdToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :area_id, :integer
    add_index :filo_elementos, :area_id
  end
end

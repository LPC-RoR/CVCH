class AddFiloOrdenIdToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :filo_orden_id, :integer
    add_index :filo_elementos, :filo_orden_id
  end
end

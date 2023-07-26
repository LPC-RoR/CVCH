class AddFlagsToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :mma_ok, :boolean
    add_column :filo_elementos, :revisar, :boolean
  end
end

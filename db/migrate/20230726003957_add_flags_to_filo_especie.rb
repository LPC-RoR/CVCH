class AddFlagsToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :mma_ok, :boolean
    add_column :filo_especies, :revisar, :boolean
  end
end

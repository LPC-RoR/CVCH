class AddListFieldToFiloElemento < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_elementos, :list_field, :string
  end
end

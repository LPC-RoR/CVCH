class AddHuellaToFiloConflicto < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_conflictos, :huella, :string
    add_index :filo_conflictos, :huella
  end
end

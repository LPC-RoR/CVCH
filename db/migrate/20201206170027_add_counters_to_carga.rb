class AddCountersToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :n_procesados, :integer
    add_column :cargas, :n_carga, :integer
    add_column :cargas, :n_duplicados, :integer
  end
end

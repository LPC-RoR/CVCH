class AddContadoresToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :n_formatos, :integer
    add_column :cargas, :n_publicadas, :integer
    add_column :cargas, :n_areas, :integer
  end
end

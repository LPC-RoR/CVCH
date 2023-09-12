class AddCamposToFiloSinonimo < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_sinonimos, :correccion, :string
    add_index :filo_sinonimos, :correccion
    add_column :filo_sinonimos, :manual, :boolean
    add_index :filo_sinonimos, :manual
  end
end

class AddArchivoCargaToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :archivo_carga, :string
  end
end

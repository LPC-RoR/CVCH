class AddTipoToFiloEspSino < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_esp_sinos, :tipo, :string
    add_index :filo_esp_sinos, :tipo
  end
end

class CreateFiloEspEsps < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_esp_esps do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :filo_esp_esps, :parent_id
    add_index :filo_esp_esps, :child_id
  end
end

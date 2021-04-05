class CreateIndDirecciones < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_direcciones do |t|
      t.integer :origen_id
      t.integer :destino_id

      t.timestamps
    end
    add_index :ind_direcciones, :origen_id
    add_index :ind_direcciones, :destino_id
  end
end

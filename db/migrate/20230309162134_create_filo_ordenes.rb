class CreateFiloOrdenes < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_ordenes do |t|
      t.integer :orden
      t.string :filo_orden

      t.timestamps
    end
    add_index :filo_ordenes, :filo_orden
  end
end

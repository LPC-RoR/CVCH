class CreatePasos < ActiveRecord::Migration[5.2]
  def change
    create_table :pasos do |t|
      t.integer :orden
      t.string :paso
      t.text :detalle
      t.integer :tutorial_id

      t.timestamps
    end
    add_index :pasos, :orden
    add_index :pasos, :tutorial_id
  end
end

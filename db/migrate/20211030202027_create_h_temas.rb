class CreateHTemas < ActiveRecord::Migration[5.2]
  def change
    create_table :h_temas do |t|
      t.integer :orden
      t.string :tema
      t.string :imagen
      t.string :credito_imagen
      t.string :detalle
      t.boolean :activo

      t.timestamps
    end
    add_index :h_temas, :orden
    add_index :h_temas, :tema
  end
end

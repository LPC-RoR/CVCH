class CreateTutoriales < ActiveRecord::Migration[5.2]
  def change
    create_table :tutoriales do |t|
      t.integer :orden
      t.string :tutorial
      t.text :detalle
      t.integer :tema_ayuda_id

      t.timestamps
    end
    add_index :tutoriales, :orden
    add_index :tutoriales, :tema_ayuda_id
  end
end

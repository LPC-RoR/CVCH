class CreateCargas < ActiveRecord::Migration[5.2]
  def change
    create_table :cargas do |t|
      t.string :archivo
      t.string :nota
      t.string :estado
      t.integer :investigador_id

      t.timestamps
    end
    add_index :cargas, :investigador_id
  end
end

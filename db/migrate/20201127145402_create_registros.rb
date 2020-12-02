class CreateRegistros < ActiveRecord::Migration[5.2]
  def change
    create_table :registros do |t|
      t.string :doi
      t.integer :institucion_id

      t.timestamps
    end
    add_index :registros, :doi
    add_index :registros, :institucion_id
  end
end

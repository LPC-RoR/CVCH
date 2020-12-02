class CreateRevistas < ActiveRecord::Migration[5.2]
  def change
    create_table :revistas do |t|
      t.string :revista
      t.integer :idioma_id

      t.timestamps
    end
    add_index :revistas, :revista
    add_index :revistas, :idioma_id
  end
end

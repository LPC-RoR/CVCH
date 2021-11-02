class CreateHLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :h_links do |t|
      t.string :tipo
      t.string :texto
      t.string :link
      t.string :owner_class
      t.string :owner_id
      t.boolean :activo

      t.timestamps
    end
    add_index :h_links, :tipo
  end
end

class CreateCategorias < ActiveRecord::Migration[5.2]
  def change
    create_table :categorias do |t|
      t.string :categoria
      t.integer :perfil_id
      t.boolean :base

      t.timestamps
    end
    add_index :categorias, :categoria
    add_index :categorias, :perfil_id
    add_index :categorias, :base
  end
end

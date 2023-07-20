class CreateBlgArticulos < ActiveRecord::Migration[5.2]
  def change
    create_table :blg_articulos do |t|
      t.string :blg_articulo
      t.integer :app_perfil_id
      t.integer :blg_tema_id
      t.string :estado
      t.string :imagen
      t.text :descripcion
      t.text :articulo

      t.timestamps
    end
    add_index :blg_articulos, :app_perfil_id
    add_index :blg_articulos, :blg_tema_id
    add_index :blg_articulos, :estado
  end
end

class CreateIndPalabras < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_palabras do |t|
      t.string :ind_palabra
      t.integer :ind_lenguaje_id
      t.integer :ind_clave_id

      t.timestamps
    end
    add_index :ind_palabras, :ind_palabra
    add_index :ind_palabras, :ind_lenguaje_id
    add_index :ind_palabras, :ind_clave_id
  end
end

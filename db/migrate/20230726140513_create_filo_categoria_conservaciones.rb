class CreateFiloCategoriaConservaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_categoria_conservaciones do |t|
      t.string :codigo
      t.string :filo_categoria_conservacion

      t.timestamps
    end
    add_index :filo_categoria_conservaciones, :codigo
  end
end

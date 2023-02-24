class CreateFiloElementos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_elementos do |t|
      t.string :filo_elemento

      t.timestamps
    end
    add_index :filo_elementos, :filo_elemento
  end
end

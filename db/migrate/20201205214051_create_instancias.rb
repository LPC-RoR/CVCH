class CreateInstancias < ActiveRecord::Migration[5.2]
  def change
    create_table :instancias do |t|
      t.string :instancia
      t.string :sha1
      t.integer :concepto_id

      t.timestamps
    end
    add_index :instancias, :sha1
    add_index :instancias, :concepto_id
  end
end

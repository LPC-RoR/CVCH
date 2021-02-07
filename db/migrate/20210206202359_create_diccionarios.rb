class CreateDiccionarios < ActiveRecord::Migration[5.2]
  def change
    create_table :diccionarios do |t|
      t.integer :concepto_id
      t.integer :instancia_id

      t.timestamps
    end
    add_index :diccionarios, :concepto_id
    add_index :diccionarios, :instancia_id
  end
end

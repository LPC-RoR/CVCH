class CreateSuscripciones < ActiveRecord::Migration[5.2]
  def change
    create_table :suscripciones do |t|
      t.integer :categoria_id
      t.integer :perfil_id

      t.timestamps
    end
    add_index :suscripciones, :categoria_id
    add_index :suscripciones, :perfil_id
  end
end

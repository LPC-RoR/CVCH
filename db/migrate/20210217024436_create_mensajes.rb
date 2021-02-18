class CreateMensajes < ActiveRecord::Migration[5.2]
  def change
    create_table :mensajes do |t|
      t.string :mensaje
      t.string :tipo
      t.string :estado
      t.string :email
      t.datetime :fecha_envio
      t.text :detalle
      t.integer :perfil_id

      t.timestamps
    end
    add_index :mensajes, :tipo
    add_index :mensajes, :estado
    add_index :mensajes, :email
    add_index :mensajes, :fecha_envio
    add_index :mensajes, :perfil_id
  end
end

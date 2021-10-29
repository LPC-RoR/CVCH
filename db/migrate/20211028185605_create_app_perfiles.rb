class CreateAppPerfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :app_perfiles do |t|
      t.string :email
      t.integer :usuario_id
      t.integer :administrador_id

      t.timestamps
    end
    add_index :app_perfiles, :email
    add_index :app_perfiles, :usuario_id
    add_index :app_perfiles, :administrador_id
  end
end

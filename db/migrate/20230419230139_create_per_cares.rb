class CreatePerCares < ActiveRecord::Migration[5.2]
  def change
    create_table :per_cares do |t|
      t.integer :app_perfil_id
      t.integer :carpeta_id

      t.timestamps
    end
    add_index :per_cares, :app_perfil_id
    add_index :per_cares, :carpeta_id
  end
end

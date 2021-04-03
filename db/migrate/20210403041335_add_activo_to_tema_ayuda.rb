class AddActivoToTemaAyuda < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :activo, :boolean
    add_index :tema_ayudas, :activo
  end
end

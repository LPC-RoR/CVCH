class CreateEcoPisos < ActiveRecord::Migration[5.2]
  def change
    create_table :eco_pisos do |t|
      t.integer :eco_formacion_id
      t.string :eco_piso

      t.timestamps
    end
    add_index :eco_pisos, :eco_formacion_id
    add_index :eco_pisos, :eco_piso
  end
end

class CreateEcoFormaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :eco_formaciones do |t|
      t.string :eco_formacion

      t.timestamps
    end
    add_index :eco_formaciones, :eco_formacion
  end
end

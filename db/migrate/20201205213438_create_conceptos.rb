class CreateConceptos < ActiveRecord::Migration[5.2]
  def change
    create_table :conceptos do |t|
      t.string :concepto

      t.timestamps
    end
    add_index :conceptos, :concepto
  end
end

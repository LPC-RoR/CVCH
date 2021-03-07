class CreateEspecies < ActiveRecord::Migration[5.2]
  def change
    create_table :especies do |t|
      t.string :especie

      t.timestamps
    end
    add_index :especies, :especie
  end
end

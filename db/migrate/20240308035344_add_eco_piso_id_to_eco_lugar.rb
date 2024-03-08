class AddEcoPisoIdToEcoLugar < ActiveRecord::Migration[5.2]
  def change
    add_column :eco_lugares, :eco_piso_id, :integer
    add_index :eco_lugares, :eco_piso_id
  end
end

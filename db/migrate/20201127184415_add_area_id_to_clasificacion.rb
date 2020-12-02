class AddAreaIdToClasificacion < ActiveRecord::Migration[5.2]
  def change
  	remove_column :clasificaciones, :coleccion_id
    add_column :clasificaciones, :area_id, :integer
    add_index :clasificaciones, :area_id
  end
end

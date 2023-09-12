class AddFiloSinonimoIdToEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :especies, :filo_sinonimo_id, :integer
    add_index :especies, :filo_sinonimo_id
  end
end

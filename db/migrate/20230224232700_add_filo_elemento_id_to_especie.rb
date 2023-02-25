class AddFiloElementoIdToEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :especies, :filo_elemento_id, :integer
    add_index :especies, :filo_elemento_id
  end
end

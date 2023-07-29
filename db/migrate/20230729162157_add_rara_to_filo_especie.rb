class AddRaraToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :rara, :boolean
  end
end

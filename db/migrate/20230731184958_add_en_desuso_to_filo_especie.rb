class AddEnDesusoToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :en_desuso, :boolean
  end
end

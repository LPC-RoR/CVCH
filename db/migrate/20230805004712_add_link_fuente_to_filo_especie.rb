class AddLinkFuenteToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :link_fuente, :string
  end
end

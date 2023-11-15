class AddSubEspecieHToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :feh, :boolean
  end
end

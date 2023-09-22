class AddTituloMultipleToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :titulo_multiple, :boolean
  end
end

class AddCiudadPaisToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :ciudad_pais, :string
  end
end

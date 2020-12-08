class AddUnicidadToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :unicidad, :string
  end
end

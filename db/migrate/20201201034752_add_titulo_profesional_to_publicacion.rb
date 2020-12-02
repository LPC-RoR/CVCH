class AddTituloProfesionalToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :academic_degree, :string
    add_column :publicaciones, :book, :string
  end
end

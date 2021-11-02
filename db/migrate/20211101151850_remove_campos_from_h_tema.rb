class RemoveCamposFromHTema < ActiveRecord::Migration[5.2]
  def change
    remove_index :h_temas, :orden
    remove_column :h_temas, :orden, :integer
    remove_column :h_temas, :imagen, :string
    remove_column :h_temas, :credito_imagen, :string
    remove_column :h_temas, :activo, :boolean
  end
end

class AddDQuoteToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :d_quote, :string
    add_column :publicaciones, :doc_type, :string
    add_column :publicaciones, :estado, :string
    add_index :publicaciones, :estado
    add_index :publicaciones, :doc_type
  end
end

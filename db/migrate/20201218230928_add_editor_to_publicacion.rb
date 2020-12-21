class AddEditorToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :editor, :string
  end
end

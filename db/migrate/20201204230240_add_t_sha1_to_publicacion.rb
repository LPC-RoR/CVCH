class AddTSha1ToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :t_sha1, :string
    add_index :publicaciones, :t_sha1
  end
end

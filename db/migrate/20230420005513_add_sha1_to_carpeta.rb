class AddSha1ToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :sha1, :string
    add_index :carpetas, :sha1
  end
end

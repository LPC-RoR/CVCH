class RemoveTipoFromHLink < ActiveRecord::Migration[5.2]
  def change
    remove_column :h_links, :tipo, :string
  end
end

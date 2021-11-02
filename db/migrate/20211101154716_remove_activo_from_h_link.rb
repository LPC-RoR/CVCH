class RemoveActivoFromHLink < ActiveRecord::Migration[5.2]
  def change
    remove_column :h_links, :activo, :boolean
  end
end

class AddOwnerIdToMejora < ActiveRecord::Migration[5.2]
  def change
    add_column :mejoras, :owner_id, :integer
  end
end

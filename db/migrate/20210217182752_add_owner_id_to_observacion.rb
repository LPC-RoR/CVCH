class AddOwnerIdToObservacion < ActiveRecord::Migration[5.2]
  def change
    add_column :observaciones, :owner_id, :integer
  end
end

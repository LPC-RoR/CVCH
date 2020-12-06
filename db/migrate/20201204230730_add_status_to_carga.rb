class AddStatusToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :status, :string
  end
end

class AddEmailToPerfil < ActiveRecord::Migration[5.2]
  def change
    add_column :perfiles, :email, :string
    add_index :perfiles, :email
  end
end

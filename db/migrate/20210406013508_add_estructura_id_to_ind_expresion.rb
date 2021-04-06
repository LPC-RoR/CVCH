class AddEstructuraIdToIndExpresion < ActiveRecord::Migration[5.2]
  def change
    add_column :ind_expresiones, :ind_estructura_id, :integer
    add_index :ind_expresiones, :ind_estructura_id
  end
end

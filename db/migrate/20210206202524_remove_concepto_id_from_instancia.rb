class RemoveConceptoIdFromInstancia < ActiveRecord::Migration[5.2]
  def change
    remove_column :instancias, :concepto_id, :integer
  end
end

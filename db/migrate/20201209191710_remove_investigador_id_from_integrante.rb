class RemoveInvestigadorIdFromIntegrante < ActiveRecord::Migration[5.2]
  def change
    remove_column :integrantes, :investigador_id, :string
  end
end

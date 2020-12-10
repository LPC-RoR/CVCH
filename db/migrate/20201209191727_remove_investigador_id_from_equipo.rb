class RemoveInvestigadorIdFromEquipo < ActiveRecord::Migration[5.2]
  def change
    remove_column :equipos, :administrador_id, :string
  end
end

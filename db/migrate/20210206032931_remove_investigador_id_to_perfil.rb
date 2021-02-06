class RemoveInvestigadorIdToPerfil < ActiveRecord::Migration[5.2]
  def change
    remove_column :perfiles, :investigador_id, :integer
  end
end

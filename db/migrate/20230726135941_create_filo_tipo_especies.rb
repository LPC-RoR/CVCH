class CreateFiloTipoEspecies < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_tipo_especies do |t|
      t.string :filo_tipo_especie

      t.timestamps
    end
  end
end

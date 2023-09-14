class CreateFiloFuentes < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_fuentes do |t|
      t.string :filo_fuente

      t.timestamps
    end
  end
end

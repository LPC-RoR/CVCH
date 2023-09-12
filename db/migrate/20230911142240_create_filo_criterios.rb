class CreateFiloCriterios < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_criterios do |t|
      t.integer :filo_conflicto_id
      t.string :problema
      t.string :criterio
      t.string :fuente
      t.string :link_fuente

      t.timestamps
    end
    add_index :filo_criterios, :filo_conflicto_id
  end
end

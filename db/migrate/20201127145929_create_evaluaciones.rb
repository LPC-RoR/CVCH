class CreateEvaluaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluaciones do |t|
      t.string :aspecto
      t.string :evaluacion
      t.integer :publicacion_id
      t.integer :investigador_id

      t.timestamps
    end
    add_index :evaluaciones, :aspecto
    add_index :evaluaciones, :publicacion_id
    add_index :evaluaciones, :investigador_id
  end
end

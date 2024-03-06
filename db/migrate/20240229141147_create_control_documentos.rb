class CreateControlDocumentos < ActiveRecord::Migration[5.2]
  def change
    create_table :control_documentos do |t|
      t.string :o_clss
      t.integer :o_id
      t.integer :orden
      t.string :nombre
      t.string :descripcion
      t.string :tipo
      t.string :control

      t.timestamps
    end
    add_index :control_documentos, :o_clss
    add_index :control_documentos, :o_id
    add_index :control_documentos, :orden
    add_index :control_documentos, :nombre
    add_index :control_documentos, :tipo
    add_index :control_documentos, :control
  end
end

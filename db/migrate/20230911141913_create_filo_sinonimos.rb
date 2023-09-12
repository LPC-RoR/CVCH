class CreateFiloSinonimos < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_sinonimos do |t|
      t.integer :filo_especie_id
      t.string :filo_sinonimo
      t.string :tipo

      t.timestamps
    end
    add_index :filo_sinonimos, :filo_especie_id
  end
end

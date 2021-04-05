class CreateIndLenguajes < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_lenguajes do |t|
      t.string :ind_lenguaje

      t.timestamps
    end
    add_index :ind_lenguajes, :ind_lenguaje
  end
end

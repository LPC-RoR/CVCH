class CreateIndClaves < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_claves do |t|
      t.string :ind_clave

      t.timestamps
    end
    add_index :ind_claves, :ind_clave
  end
end

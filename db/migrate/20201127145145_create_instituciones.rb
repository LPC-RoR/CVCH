class CreateInstituciones < ActiveRecord::Migration[5.2]
  def change
    create_table :instituciones do |t|
      t.string :institucion

      t.timestamps
    end
  end
end

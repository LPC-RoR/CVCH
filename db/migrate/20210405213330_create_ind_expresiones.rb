class CreateIndExpresiones < ActiveRecord::Migration[5.2]
  def change
    create_table :ind_expresiones do |t|
      t.string :ind_expresion

      t.timestamps
    end
  end
end

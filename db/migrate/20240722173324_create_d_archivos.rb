class CreateDArchivos < ActiveRecord::Migration[7.1]
  def change
    create_table :d_archivos do |t|
      t.string :archivo

      t.timestamps
    end
  end
end

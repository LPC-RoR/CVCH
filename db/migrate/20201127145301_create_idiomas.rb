class CreateIdiomas < ActiveRecord::Migration[5.2]
  def change
    create_table :idiomas do |t|
      t.string :idioma

      t.timestamps
    end
    add_index :idiomas, :idioma
  end
end

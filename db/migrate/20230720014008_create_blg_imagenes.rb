class CreateBlgImagenes < ActiveRecord::Migration[5.2]
  def change
    create_table :blg_imagenes do |t|
      t.string :blg_imagen
      t.string :imagen
      t.string :credito_imagen

      t.timestamps
    end
  end
end

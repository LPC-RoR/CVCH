class AddIlustracionCacheToTemaAyudas < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :ilustracion_cache, :string
  end
end

class AddIlustracionToTemaAyudas < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :ilustracion, :string
  end
end

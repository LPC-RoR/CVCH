class AddCreditoToTemaAyuda < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :credito, :string
  end
end

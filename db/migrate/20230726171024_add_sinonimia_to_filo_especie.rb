class AddSinonimiaToFiloEspecie < ActiveRecord::Migration[5.2]
  def change
    add_column :filo_especies, :sinonimia, :text
  end
end

class AddJournalToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :journal, :string
  end
end

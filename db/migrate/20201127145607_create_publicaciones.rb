class CreatePublicaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :publicaciones do |t|
      t.string :unique_id
      t.string :origen
      t.string :title
      t.string :author
      t.string :doi
      t.string :year
      t.string :volume
      t.string :pages
      t.string :month
      t.string :publisher
      t.string :abstract
      t.string :link
      t.string :author_email
      t.string :issn
      t.string :eissn
      t.string :address
      t.string :affiliation
      t.string :article_number
      t.string :keywords
      t.string :keywords_plus
      t.string :research_areas
      t.string :web_of_science_categories
      t.string :da
      t.string :d_journal
      t.string :d_author
      t.string :d_doi
      t.integer :registro_id
      t.integer :revista_id
      t.integer :equipo_id
      t.integer :investigador_id

      t.timestamps
    end
    add_index :publicaciones, :unique_id
    add_index :publicaciones, :origen
    add_index :publicaciones, :title
    add_index :publicaciones, :registro_id
    add_index :publicaciones, :revista_id
    add_index :publicaciones, :equipo_id
    add_index :publicaciones, :investigador_id
  end
end

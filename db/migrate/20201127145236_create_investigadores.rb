class CreateInvestigadores < ActiveRecord::Migration[5.2]
  def change
    create_table :investigadores do |t|
      t.string :investigador
      t.string :orcid
      t.string :email
      t.integer :departamento_id

      t.timestamps
    end
    add_index :investigadores, :investigador
    add_index :investigadores, :departamento_id
  end
end

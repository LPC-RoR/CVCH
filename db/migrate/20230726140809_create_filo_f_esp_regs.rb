class CreateFiloFEspRegs < ActiveRecord::Migration[5.2]
  def change
    create_table :filo_f_esp_regs do |t|
      t.integer :filo_especie_id
      t.integer :region_id

      t.timestamps
    end
    add_index :filo_f_esp_regs, :filo_especie_id
    add_index :filo_f_esp_regs, :region_id
  end
end

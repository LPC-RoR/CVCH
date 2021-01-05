class AddDeviseFields < ActiveRecord::Migration[5.2]
  def change
      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
    add_column :usuarios, :sign_in_count, :integer, default: 0, null: false
      # t.datetime :current_sign_in_at
    add_column :usuarios, :current_sign_in_at, :datetime
      # t.datetime :last_sign_in_at
    add_column :usuarios, :last_sign_in_at, :datetime
      # t.inet     :current_sign_in_ip
    add_column :usuarios, :current_sign_in_ip, :inet
      # t.inet     :last_sign_in_ip
    add_column :usuarios, :last_sign_in_ip, :inet

      ## Confirmable
      # t.string   :confirmation_token
    add_column :usuarios, :confirmation_token, :string
      # t.datetime :confirmed_at
    add_column :usuarios, :confirmed_at, :datetime
      # t.datetime :confirmation_sent_at
    add_column :usuarios, :confirmation_sent_at, :datetime
      # t.string   :unconfirmed_email # Only if using reconfirmable
    add_column :usuarios, :unconfirmed_email, :string

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :usuarios, :failed_attempts, :integer, default: 0, null: false
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
    add_column :usuarios, :unlock_token, :string
      # t.datetime :locked_at
    add_column :usuarios, :locked_at, :datetime

    add_index :usuarios, :confirmation_token,   unique: true
    add_index :usuarios, :unlock_token,         unique: true
  end
end

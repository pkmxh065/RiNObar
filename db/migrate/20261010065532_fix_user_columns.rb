class FixUserColumns < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :email, :string if column_exists?(:users, :email)
    remove_column :users, :encryptecd_password, :string if column_exists?(:users, :encryptecd_password)
    remove_column :users, :password, :string if column_exists?(:users, :password)
    remove_column :users, :reset_password_token, :string if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at, :datetime if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at, :datetime if column_exists?(:users, :remember_created_at)
      
    unless column_exists?(:users, :password_digest)
      add_column :users, :password_digest, :string, null: false
    end
  end
end

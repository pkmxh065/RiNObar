class RemoveOldEmailIndexFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_index :users, name: :index_users_on_email if index_exists?(:users, name: :index_users_on_email)
  end
end

class RemoveUserIdFromUsers < ActiveRecord::Migration[8.1]
  def change
    if column_exists?(:users, :user_id)
      remove_column :users, :user_id, :integer
    end
  end
end

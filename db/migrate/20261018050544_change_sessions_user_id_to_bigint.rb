class ChangeSessionsUserIdToBigint < ActiveRecord::Migration[8.1]
  def change
    change_column :sessions, :user_id, :bigintm, null: false
  end
end

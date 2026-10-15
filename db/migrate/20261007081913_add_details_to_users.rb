class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :user_id, :integer
    add_column :users, :name, :string
    add_column :users, :email_address, :string
    add_column :users, :password, :string
  end
end

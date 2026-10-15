class AddUserIdToNovels < ActiveRecord::Migration[8.1]
  def change
    add_reference :novels, :user, null: false, foreign_key: true
  end
end

class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :novel, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :novel_id], unique: true
  end
end

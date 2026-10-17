class CreateNovels < ActiveRecord::Migration[8.1]
  def change
    create_table :novels do |t|
      t.integer :user_id
      t.integer :novel_id
      t.string :title
      t.string :genre
      t.text :story
      t.text :thought

      t.timestamps
    end
  end
end

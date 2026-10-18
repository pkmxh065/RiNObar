class CreateNovels < ActiveRecord::Migration[8.1]
  def change
    create_table :novels do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :novel_id
      t.string :title
      t.string :genre
      t.text :story
      t.text :thought

      t.timestamps
    end
  end
end

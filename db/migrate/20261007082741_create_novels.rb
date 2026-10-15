class CreateNovels < ActiveRecord::Migration[8.1]
  def change
    create_table :novels do |t|
      t.integer :novel_id
      t.string :title
      t.text :genre
      t.string :story
      t.string :thought

      t.timestamps
    end
  end
end

class ChangeGenreColumnsInNovels < ActiveRecord::Migration[8.1]
  def change
    rename_column :novels, :genre, :genre_main
    add_column :novels, :genre_sub, :string
  end
end

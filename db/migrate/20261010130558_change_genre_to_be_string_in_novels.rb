class ChangeGenreToBeStringInNovels < ActiveRecord::Migration[8.1]
  def change
    change_column :novels, :genre, :string
  end
end

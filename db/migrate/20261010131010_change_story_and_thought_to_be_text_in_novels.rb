class ChangeStoryAndThoughtToBeTextInNovels < ActiveRecord::Migration[8.1]
  def change
    change_column :novels, :story, :text
    change_column :novels, :thought, :text
  end
end

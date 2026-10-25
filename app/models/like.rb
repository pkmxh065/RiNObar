class Like < ApplicationRecord
  belongs_to :user
  belongs_to :novel

  validates :user_id, uniqueness: { scope: :novel_id }
  
  validate :cannot_like_own_novel

  private

  def cannot_like_own_novel
    if novel && novel.user_id == user_id
      errors.add(:base, "自分の投稿にはいいねできません。")
    end
  end
end

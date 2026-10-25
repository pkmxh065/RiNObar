class Novel < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    return false unless user
    likes.exists?(user_id: user.id)
  end

  validates :title, presence: true
  validates :story, presence: true
  validates :genre_main, presence: true
  validates :genre_sub, presence: true
  validates :thought, presence: true
end

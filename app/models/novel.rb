class Novel < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :story, presence: true
  validates :genre_main, presence: true
  validates :genre_sub, presence: true
  validates :thought, presence: true
end

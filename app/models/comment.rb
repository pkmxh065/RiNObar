class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :novel

  validates :body, presence: true
end

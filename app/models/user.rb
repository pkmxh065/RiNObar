class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password

  has_one_attached :image
  has_many :sessions, dependent: :destroy
  has_many :novels, dependent: :destroy

  validates :name, presence: true
  validates :email_address, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end

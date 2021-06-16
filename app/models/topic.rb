class Topic < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 300}
  mount_uploader :image, ImageUploader
end

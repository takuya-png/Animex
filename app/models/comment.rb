class Comment < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates :content, presence: true, length:{ maximum: 255 }
  mount_uploader :image, ImageUploader
end

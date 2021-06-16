class User < ApplicationRecord
  has_many :topics
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:trackable, :validatable, :confirmable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :favorites
  has_many :favorite_cities, through: :favorites, class_name: 'City', source: :city
  has_secure_password
end

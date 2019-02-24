class Background::Keyword < ApplicationRecord
  validates_presence_of :word

  has_many :taggings
  has_many :images, through: :taggings
end

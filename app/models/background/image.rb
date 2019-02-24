class Background::Image < ApplicationRecord
  validates_presence_of :source

  has_many :taggings
  has_many :keywords, through: :taggings
end

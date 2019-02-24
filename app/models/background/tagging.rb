class Background::Tagging < ApplicationRecord
  belongs_to :image
  belongs_to :keyword
end

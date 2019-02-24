require "rails_helper"

RSpec.describe Background::Image, type: :model do
  describe 'validations' do
    it { should validate_presence_of :source }
  end
  describe 'relationships' do
    it { should have_many :taggings }
    it { should have_many :keywords }
  end
end

require "rails_helper"

RSpec.describe Background::Keyword, type: :model do
  describe 'validations' do
    it { should validate_presence_of :word }
  end
  describe 'relationships' do
    it { should have_many :taggings }
    it { should have_many :images }
  end
end

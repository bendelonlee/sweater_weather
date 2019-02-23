require "rails_helper"

RSpec.describe City, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :image }
  end
  describe 'relationships' do
    it { should have_one :forecast }
  end
end

require "rails_helper"

describe City do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :image }
  end
  describe 'relationships' do
    it { should have_one :weather }
  end
end

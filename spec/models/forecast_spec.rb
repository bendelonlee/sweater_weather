require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'relationships' do
    it { should belong_to :city }
  end
  describe 'class_methods' do
    it '.from_service' do
      
    end
  end
end

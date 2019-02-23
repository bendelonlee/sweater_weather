require 'rails_helper'

RSpec.describe Forecast, type: :model do
  include ForecastSpecHelpers
  describe 'relationships' do
    it { should belong_to :city }
  end
  describe 'class_methods' do
    it '.from_service' do
      stub_service
      stub_days
      stub_hours
      Forecast.from_service(@service)
      expect(Forecast.count).to eq(1)
      expect(Forecast.days.count).to eq(8)
      expect(Forecast.hours.count).to eq(48)
    end
  end
end

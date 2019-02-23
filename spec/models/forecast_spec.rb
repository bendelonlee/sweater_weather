require 'rails_helper'

RSpec.describe Forecast, type: :model do
  include ForecastSpecHelpers
  describe 'relationships' do
    it { should belong_to :city }
  end
  describe 'class_methods' do
    it '.from_service' do
      stub_service
      stub_days(Time.now)
      stub_hours(Time.now)
      city = create(:city)
      forecast = Forecast.from_service(@service, city)
      expect(Forecast.count).to eq(1)
      expect(forecast.days.count).to eq(8)
      expect(forecast.days.first).to be_a(Forecast::Day)
      # expect(Forecast.hours.count).to eq(48)
    end
  end
end

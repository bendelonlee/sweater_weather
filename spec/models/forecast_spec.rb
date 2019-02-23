require 'rails_helper'

RSpec.describe Forecast, type: :model do
  include ForecastSpecHelpers
  describe 'validations' do
    it { should validate_presence_of :day_summary }
    it { should validate_presence_of :week_summary }
    it { should validate_presence_of :days_data }
    it { should validate_presence_of :hours_data }
  end
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
      expect(forecast.hours.count).to eq(49)
      expect(forecast.hours.first).to be_a(Forecast::Hour)
    end
    describe 'instance_methods' do
      describe 'when already in the database' do
        it 'returns .days and .hours' do
          stub_service
          stub_days(Time.now)
          stub_hours(Time.now)
          city = create(:city)
          Forecast.from_service(@service, city)
          expect(Forecast.first.days.count).to eq(8)
          expect(Forecast.first.days.first).to be_a(Forecast::Day)
          expect(Forecast.first.hours.count).to eq(49)
          expect(Forecast.first.hours.first).to be_a(Forecast::Hour)
        end
      end
    end
  end
end

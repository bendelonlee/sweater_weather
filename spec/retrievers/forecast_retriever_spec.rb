require "rails_helper"

describe ForecastRetriever do
  include ForecastSpecHelpers
  describe ".find_or_fetch" do
    before(:each) do
      stub_service
      stub_hours
      stub_days
    end
    it "fetches" do
      retriever = ForecastRetriever.new
      expect do
        retriever.find_or_fetch(create(:city))
      end.to change{Forecast.count}.from(0).to(1)
    end
    it 'finds' do
      retriever = ForecastRetriever.new
      city = create(:city)
      retriever.find_or_fetch(city)
      expect do
        retriever.find_or_fetch(city)
      end.to_not change{Forecast.count}
    end
  end
  it 'refresh_all' do
    VCR.use_cassette('refresh_all') do
      city_1     = create(:city, name: "San Diego", latitude: 32.7157, longitude: -95.1611, timezone_offset: 0)
      city_2     = create(:city, name: "Berlin", latitude: 32.7157, longitude: -80.1611, timezone_offset: 0)
      old_forecast_1 = build(:forecast)
      old_forecast_2 = build(:forecast)
      city_1.forecast = old_forecast_1
      city_2.forecast = old_forecast_2

      forecast_retriever = ForecastRetriever.new
      forecast_retriever.refresh_all
      city_1.reload
      city_2.reload
      expect(city_1.forecast.reload).to_not eq(old_forecast_1)
      expect(city_2.forecast.reload).to_not eq(old_forecast_2)
      expect(city_1.forecast.days.first).to be_a(Forecast::Day)
      expect(city_1.forecast.days.size).to be_between(6, 9)
    end
  end
end

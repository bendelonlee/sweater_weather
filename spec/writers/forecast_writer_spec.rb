require "rails_helper"

describe ForecastWriter do
  include ForecastSpecHelpers
  describe ".find_or_fetch" do
    before(:each) do
      stub_service
      stub_hours
      stub_days
    end
    it "fetches" do
      writer = ForecastWriter.new
      expect do
        writer.find_or_fetch(create(:city))
      end.to change{Forecast.count}.from(0).to(1)
    end
    it 'finds' do
      writer = ForecastWriter.new
      city = create(:city)
      writer.find_or_fetch(city)
      expect do
        writer.find_or_fetch(city)
      end.to_not change{Forecast.count}
    end
  end
end

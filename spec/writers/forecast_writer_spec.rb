require "rails_helper"

describe ForecastWriter do
  def stub_service
    @city_name = "Denvertropolis"
    @city = double(@city_name)
    @service_class = spy("WeatherService")
    @service       = spy("weather_service")
    stub_const("DarkSkyService", @service_class )
    allow(@service_class).to receive(:new).and_return( @service )
    @service.stub(
      day_summary:  @day_summary  = "A beautiful day",
      week_summary: @week_summary = "A beautiful week",
    )
  end

  def stub_hours(starting_time)
    (0..48).each do |i|
      hour = double("hour-#{i}")
      hour.stub(
        icon: "sun",
        summary: "The perfect hour",
        time: (starting_time.beginning_of_hour + i.hours).strp_time('%s'),
        temperature: (100 + i),
        apparentTemperature: (200 + i),
        humidity: i,
        visibility: 100 - i,
        uvIndex: i / 10
      )
      allow(@service).to receive(:weather_at_hour).with(0).and_return(hour)
    end
  end

  def stub_days(starting_time)
    (0..7).each do |i|
      day = double("day-#{i}")
      day.stub(
        icon: "sun-icon",
        summary: "The perfect day",
        time: (starting_time + i.days).strp_time('%s'),
        temperatureHigh: (100 + i),
        temperatureLow: (0 + i),
        precipProbability: (i / 10.0),
        precipType: 'rain'
      )
      allow(@service).to receive(:weather_at_day).with(0).and_return(day)
    end
  end

  describe ".find_or_fetch" do
    before(:each) do
      stub_service
    end
    describe "it find" do
      describe "the hour's weather" do
        scenario 'when the forecast was retrieved this hour' do
          expect do
            ForecastWriter.find_or_fetch(city: @city)
          end.to change{Forecast.count}.from(0).to(1)
        end
        scenario 'when the forecast was retrieved earlier' do

        end
      end
    end
  end
end

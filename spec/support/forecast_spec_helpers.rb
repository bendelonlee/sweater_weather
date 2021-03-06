require "rails_helper"

module ForecastSpecHelpers
  def stub_service
    @city_name = "Denvertropolis"
    @city = double(@city_name)
    @service_class = spy("WeatherService")
    @service       = spy("weather_service")
    stub_const("DarkSkyService", @service_class )
    allow(@service_class).to receive(:new).and_return( @service )
    allow(@service).to receive_messages(
      day_summary:  @day_summary  = "A beautiful day",
      week_summary: @week_summary = "A beautiful week",
      weather_at_day: day_hash,
      hours_at: hour_hash
    )
  end

  def stub_hours(starting_time = Time.now)
    (0..48).each do |i|
      allow(@service).to receive(:weather_at_hour).with(i) do
        hour_hash(starting_time = Time.now, i = 0)
      end
    end
  end

  def hour_hash(starting_time = Time.now, i = 0)
    {
      icon: "sun",
      summary: "The perfect hour",
      time: (starting_time.beginning_of_hour + i.hours).strftime('%s').to_i,
      temperature: (100 + i),
      apparentTemperature: (200 + i),
      humidity: i,
      visibility: 100 - i,
      uvIndex: i / 10
    }
  end

  def stub_days(starting_time = Time.now)
    (0..7).each do |i|
      allow(@service).to receive(:weather_at_day).with(i) do
        day_hash(starting_time, i)
      end
    end
  end

  def day_hash(starting_time = Time.now, i = 0)
    {
      icon: "sun-icon",
      summary: "The perfect day",
      time: (starting_time + i.days).strftime('%s').to_i,
      temperatureHigh: (100 + i),
      temperatureLow: (0 + i),
      precipProbability: (i / 10.0),
      precipType: 'rain'
    }

  end
end

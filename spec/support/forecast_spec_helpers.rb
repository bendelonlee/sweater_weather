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
    )
  end

  def stub_hours(starting_time)
    (0..48).each do |i|
      hour = double("hour-#{i}")
      allow(hour).to receive_messages(
        icon: "sun",
        summary: "The perfect hour",
        time: (starting_time.beginning_of_hour + i.hours).strftime('%s'),
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
      allow(day).to receive_messages(
        icon: "sun-icon",
        summary: "The perfect day",
        time: (starting_time + i.days).strftime('%s'),
        temperatureHigh: (100 + i),
        temperatureLow: (0 + i),
        precipProbability: (i / 10.0),
        precipType: 'rain'
      )
      allow(@service).to receive(:weather_at_day).with(0).and_return(day)
    end
  end
end

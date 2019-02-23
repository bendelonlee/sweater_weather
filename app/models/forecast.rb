class Forecast < ApplicationRecord
  belongs_to :city
  def self.from_service(service, city)
    forecast = Forecast.create(
      day_summary:  service.day_summary,
      week_summary: service.week_summary,
      city: city
    )
    forecast.add_weather_data(service)
    forecast
  end

  def days
    @_days = days_data.map do |day|
      Forecast::Day.new(day.symbolize_keys)
    end
  end

  def add_weather_data(service)
    self.days_data = add_days(service).as_json
    add_hours(service)
  end

  def add_days(service)
    @_days = (0..7).map do |i|
      Forecast::Day.new(service.day_at(i))
    end
    self.days_data = @_days.as_json
  end

  def add_hours(service)
    self.hours_data = (0..48).map do |i|
      Forecast::Hour.from_hash(service.day_at(i))
    end
  end
end

class Forecast < ApplicationRecord
  belongs_to :city
  validates_presence_of :day_summary, :week_summary, :days_data, :hours_data

  def self.from_service(service, city)
    forecast = Forecast.new(
      day_summary:  service.day_summary,
      week_summary: service.week_summary,
      city: city
    )
    forecast.add_weather_data(service)
    forecast.save!
    forecast
  end

  def hours
    @_hours ||= hours_data.map do |hour|
      Forecast::Hour.new(hour.symbolize_keys)
    end
  end

  def days
    @_days ||= days_data.map do |day|
      Forecast::Day.new(day.symbolize_keys)
    end
  end

  def add_weather_data(service)
    add_days(service)
    add_hours(service)
  end

  private

  def add_hours(service)
    @_hours = (0..48).map do |i|
      Forecast::Hour.new(service.weather_at_hour(i))
    end
    self.hours_data = @_hours.as_json rescue binding.pry
  end

  def add_days(service)
    @_days = (0..7).map do |i|
      Forecast::Day.new(service.weather_at_day(i))
    end
    self.days_data = @_days.as_json
  end
end

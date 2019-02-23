class Forecast < ApplicationRecord
  belongs_to :city
  def self.from_service(service)
    forecast = Forecast.create(
      day_summary:  service.day_summary,
      week_summary: service.week_summary
    )
    forecast.add_children
  end

  def add_children
    add_days
    add_hours
  end

  def add_days
    @days = 8.times do |i|
      DayWeather.from_hash(service.day_at(i))
    end
  end

  def add_hours
    @hours = 48.times do |i|
      HourWeather.from_hash(service.day_at(i))
    end
  end
end

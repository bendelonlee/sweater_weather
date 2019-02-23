class Forecast < ApplicationRecord
  belongs_to :city
  def self.from_service(service)
    forecast = Forecast.create(
      day_summary:  service.day_summary,
      week_summary: service.week_summary
    )
    forecast.add_children(service)
  end

  def add_children(service)
    add_days(service)
    add_hours(service)
  end

  def add_days(service)
    @days = 8.times do |i|
      Forecast::Day.from_hash(service.day_at(i))
    end
  end

  def add_hours(service)
    @hours = 48.times do |i|
      Forecast::Hour.from_hash(service.day_at(i))
    end
  end
end

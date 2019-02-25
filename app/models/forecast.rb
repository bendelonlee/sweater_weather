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

  def current_hour
    hours[current_hour_index]
  end

  def today_index
    days.find_index do |day|
      day.time == Date.today
    end
  end

  def future_days
    days[today_index .. -1]
  end

  def current_hour_index
    hours.find_index {|hour| hour.time == Time.now.beginning_of_hour}
  end

  def future_hours
    hours[current_hour_index .. (current_hour_index + 20)]
  end

  private

  def add_hours(service)
    @_hours = (0..48).map do |i|
      Forecast::Hour.new(service.weather_at_hour(i))
    end
    self.hours_data = @_hours.as_json
  end

  def add_days(service)
    @_days = (0..7).map do |i|
      Forecast::Day.new(service.weather_at_day(i))
    end
    self.days_data = @_days.as_json
  end
end

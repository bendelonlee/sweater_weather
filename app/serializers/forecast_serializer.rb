class ForecastSerializer < ActiveModel::Serializer
  belongs_to :city
  attributes :id,
             :day_summary, :week_summary,
             :current_hour, :current_day,
             :hours, :days,
             :current_time

  def current_time
    (Time.now.utc + object.city.timezone_offset.seconds).strftime('%l:%M %p')
  end

  def current_day
    object.days[object.today_index]
  end

  def current_hour
    object.hours[object.current_hour_index]
  end

  def days
    object.future_days.map do |day|
      Forecast::DaySerializer.new(day, root: false)
    end
  end

  def hours
    object.future_hours.map do |hour|
      Forecast::HourSerializer.new(hour, root: false)
    end
  end
end

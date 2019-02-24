class ForecastSerializer < ActiveModel::Serializer
  attributes :id,
             :day_summary, :week_summary,
             :current_hour, :current_day,
             :hours, :days
  belongs_to :city

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

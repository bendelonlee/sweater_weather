class Forecast::DaySerializer < ActiveModel::Serializer
  attributes :icon, :day_of_week, :high, :low,
             :precip_probability, :precip_type
  def day_of_week
    object.time.strftime('%A')
  end
end

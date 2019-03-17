class Forecast::HourSerializer < ActiveModel::Serializer
  attributes :temperature, :time_of_day, :icon
  def time_of_day
    (object.time.utc + object.timezone_offset.seconds).strftime('%l %p')
  end
end

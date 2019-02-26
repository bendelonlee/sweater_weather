class Forecast::HourSerializer < ActiveModel::Serializer
  attributes :temperature, :time_of_day
  def time_of_day
    object.time.utc
  end
end

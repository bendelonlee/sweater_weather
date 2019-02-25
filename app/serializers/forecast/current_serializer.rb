class Forecast::CurrentSerializer < ActiveModel::Serializer
  attributes :id,
             :name, :state, :country,
             :current_weather

  def current_weather
    object.forecast.current_hour
  end

end

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :day_summary, :week_summary
  has_one  :current_weather_info
  has_one  :location_info
  has_many :days
  has_many :hours
end

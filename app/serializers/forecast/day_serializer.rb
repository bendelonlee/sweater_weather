class Forecast::DaySerializer < ActiveModel::Serializer
  attributes :icon, :day_of_week, :high, :low,
             :precip_probability, :precip_type
  def day_of_week
    object.time.strftime('%A')
  end

  def precip_probability
    return (object.precip_probability * 100).to_i.to_s + "%"
  end
end

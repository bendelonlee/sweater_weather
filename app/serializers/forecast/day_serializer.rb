class Forecast::DaySerializer < ActiveModel::Serializer
  attributes :icon, :day_of_week, :high, :low,
             :precip_probability, :precip_type
  def day_of_week
    object.time.strftime('%A')
  end

  def precip_probability
    return '0' if object.precip_probability == 0
    prob_string = object.precip_probability.to_s[/(?<=\.)\d+/]
    if prob_string && prob_string.first == '0'
      prob_string[0] = ''
    end
    "#{prob_string}%"
  end
end

class Forecast::Day
  attr_reader :time,
              :high, :low,
              :icon, :summary,
              :precip_probability, :precip_type

  def initialize(args)
      @icon               = args[:icon]
      @summary            = args[:summary]
      @time               = format_time(args[:time]) rescue binding.pry
      @high               = args[:temperatureHigh]
      @low                = args[:temperatureLow]
      @precip_probability = args[:precipProbability]
      @precip_type        = args[:precipType]
  end

  def format_time(data)
    DateTime.strptime(data.to_s, '%s') if data.is_a?(Integer)
  end

  def read_attribute_for_serialization(attr)
    send(attr)
  end

end

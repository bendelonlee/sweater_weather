class Forecast::Day
  attr_reader :time,
              :high, :low,
              :icon, :summary,
              :precip_probability, :precip_type

  def initialize(args)
      @icon               = args[:icon]
      @summary            = args[:summary]
      @time               = format_time(args[:time])
      @high               = format_tempuerature(args[:temperatureHigh]) || format_tempuerature(args[:high])
      @low                = format_tempuerature(args[:temperatureLow]) || format_tempuerature(args[:low])
      @precip_probability = args[:precipProbability] || args[:precip_probability]
      @precip_type        = args[:precipType] || args[:precip_type]

  end

  def format_time(data)
    data.is_a?(Integer) ? Date.strptime(data.to_s, '%s') : data.to_date
  end

  def format_tempuerature(temperature)
    temperature.round.to_i if temperature
  end

  def read_attribute_for_serialization(attr)
    send(attr)
  end

end

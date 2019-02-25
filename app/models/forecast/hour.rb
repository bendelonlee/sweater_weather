class Forecast::Hour
  attr_reader :time,
              :icon, :summary,
              :temperature, :feels_like,
              :humidity, :visibility, :uv_index,
              :precip_probability, :precip_type

  def initialize(args)
    @icon          = args[:icon]
    @summary       = args[:summary]
    @time          = format_time(args[:time])
    @temperature   = args[:temperature]
    @feels_like    = args[:apparentTemperature] || args[:feels_like]
    @humidity      = args[:humidity]
    @visibility    = args[:visibility]
    @uv_index      = args[:uvIndex] || args[:uv_index]
  end

  def format_time(data)
    data.is_a?(Integer) ? DateTime.strptime(data.to_s, '%s') : data.to_datetime
  end

  def read_attribute_for_serialization(attr)
    send(attr)
  end
end

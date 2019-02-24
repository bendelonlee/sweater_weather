class Forecast::Hour
  attr_reader :time,
              :icon, :summary,
              :temperature, :feels_like,
              :humidity, :visibility, :uv_index,
              :precip_probability, :precip_type

  def initialize(args)
    @icon          = args[:icon] rescue binding.pry
    @summary       = args[:summary]
    @time          = format_time(args[:time]) rescue binding.pry
    @temperature   = args[:temperature]
    @feels_like    = args[:apparentTemperature]
    @humidity      = args[:humidity]
    @visibility    = args[:visibility]
    @uv_index      = args[:uvIndex]
  end

  def format_time(data)
    DateTime.strptime(data.to_s, '%s') if data.is_a?(Integer)
  end
end

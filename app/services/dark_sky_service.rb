class DarkSkyService
  def initialize(object)
    @latitude = object.latitude
    @longitude = object.longitude
  end

  def day_summary
    response[:hourly][:summary]
  end

  def week_summary
    response[:daily][:summary]
  end

  def weather_at_day(day)
    response[:daily][:data][day]
  end

  def weather_at_hour(hour)
    response[:hourly][:data][hour]
  end

  private

  def response
    @_response ||= JSON.parse( get_json.body, symbolize_names: true )
  end

  def get_json
    connection.get("forecast/#{ENV['DARK_SKY_API_KEY']}/#{coordinates}")
  end

  def coordinates
    "#{@latitude},#{@longitude}"
  end

  def connection
    Faraday.new(url: 'https://api.darksky.net') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end

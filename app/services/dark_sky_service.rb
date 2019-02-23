class DarkSkyService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def day_summary
    response[:hourly][:summary]
  end

  def week_summary
    response[:daily][:summary]
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

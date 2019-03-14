class GoogleTimezoneService
  def initialize(coordinates)
    @coordinates = coordinates
  end

  def timezone_offset
    response[:dstOffset].to_i + response[:rawOffset].to_i
  end

  def response
    @_response ||= JSON.parse( get_json.body, symbolize_names: true )
  end

  def get_json
    connection.get('/maps/api/timezone/json?')
  end

  def location
    "#{@coordinates[:lat]},#{@coordinates[:lng]}"
  end

  def connection
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GOOGLE_GEOCODER_API_KEY']
      f.params[:location] = location
      f.params[:timestamp] = Time.now.beginning_of_day.strftime('%s')
    end
  end

end

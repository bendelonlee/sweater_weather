class GoogleGeocoderService
  def initialize(address)
    @address = address
  end

  def coordinates
    response[:results][0][:geometry][:location]
  end

  def city
    response[:results][0][:address_components][0][:short_name]
  end

  def state
    response[:results][0][:address_components][2][:short_name]
  end

  def country
    response[:results][0][:address_components][-1][:long_name]
  end

  private

  def response
    @_response ||= JSON.parse( get_json.body, symbolize_names: true )
  end

  def get_json
    connection.get('/maps/api/geocode/json?')
  end

  def connection
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GOOGLE_GEOCODER_API_KEY']
      f.params[:address] = @address
    end
  end
end

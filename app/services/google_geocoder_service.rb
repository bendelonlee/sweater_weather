class GoogleGeocoderService
  def coordinates(address)
    get_json('/maps/api/geocode/json?') do |request|
      request.params[:address] = address
    end
  end

  private

  def get_json(path, &block)
    JSON.parse( get_response(path, block).body, symbolize_names: true )
  end

  def get_response(path, block)
    connection.get(path) do |f|
      block.call(f)
    end
  end

  def connection
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GOOGLE_GEOCODER_API_KEY']
    end
  end
end

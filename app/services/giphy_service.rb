class GiphyService
  def initialize(args)
    @city = args[:city]
    @forecast_child = args[:forecast_child]
  end

  def gif_data
    {
      summary: @forecast_child.summary,
      time: @forecast_child.time,
      gif_url: get_gif_url,
    }
  end

  private

  def get_gif_url
    parse_gif_data[:data][0][:embed_url]
  end

  def parse_gif_data
    JSON.parse(fetch_gif_data.body, symbolize_names: true)
  end

  def fetch_gif_data
    @_data ||= connection.get("v1/gifs/search")
  end

  def connection
    Faraday.new(url: 'https://api.giphy.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['GIPHY_API_KEY']
      f.params[:q] = @forecast_child.icon
      f.params[:limit] = 1
      f.params[:offset] = 0
      f.params[:rating] = 'G'
      f.params[:lang] = 'en'
    end
  end
end

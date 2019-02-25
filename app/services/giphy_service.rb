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
    JSON.parse(fetch_gif_data.body, symbolize_names: true)[:data][0][:embed_url]
  end

  def fetch_gif_data
    @_data ||= connection.get("v1/stickers/search")
  end

  def connection
    Faraday.new(url: 'https://api.giphy.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['GIPHY_API_KEY']
      f.params[:q] = @forecast_child.summary
      f.params[:limit] = 1
      f.params[:offset] = 0
      f.params[:rating] = 'G'
      f.params[:lang] = 'en'
    end
  end
end

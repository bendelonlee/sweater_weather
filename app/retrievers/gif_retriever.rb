class GifRetriever
  def find_or_fetch(forecast_child)
    if found_gif = find_gif(forecast_child)
      found_gif
    else
      Gif.new(service(forecast_child).gif_data)
    end
  end

  def initialize(forecast)
    @forecast = forecast
  end

  def days
    @forecast.days.map do |day|
      find_or_fetch(day)
    end
  end

  def find_gif(forecast_child)
    Gif.find_by(icon: forecast_child.icon)
  end

  private

  def service(forecast_child)
    GiphyService.new(forecast_child: forecast_child, city: @forecast.city)
  end


end

class GifWriter
  def find_or_fetch(forecast_child)
    if found_gif = find_gif(forecast_child)
      found_gif
    else
      Gif.new(GiphyService.get_gif(forecast_child))
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
    Gif.find_by(summary: forecast_child.summary, city: @forecast.city)
  end


end
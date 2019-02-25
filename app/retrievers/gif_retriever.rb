class GifRetriever
  def find_or_fetch(forecast_child)
    if found_gif = find_unique_gif(forecast_child)
      found_gif
    else
      Gif.save_from_array(service(forecast_child).all_gif_data, forecast_child.icon)
      find_unique_gif(forecast_child)
    end
  end

  def fetch(index)
    Gif.new(service(forecast_child, index).one_gif_data)
  end

  def initialize(forecast)
    @forecast = forecast
  end

  def days
    @_days = []
    @forecast.days.each do |day|
      @_days << find_or_fetch(day)
    end
    @_days
  end

  def already_used_gif_urls
    @_days.pluck(:gif_url)
  end

  def find_unique_gif(forecast_child)
    Gif.where(icon: forecast_child.icon)
       .where.not(gif_url: [already_used_gif_urls])
       .first
  end

  private

  def service(forecast_child, index = 0)
    GiphyService.new(forecast_child: forecast_child,
                      city: @forecast.city)
  end


end

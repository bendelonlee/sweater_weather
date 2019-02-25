class GifWriter
  def self.find_or_fetch(forecast_child)
    Gif.new(GiphyService.get_gif(forecast_child))
  end

  def initialize(forecast)
    @forecast = forecast
  end

  def days
    @forecast.days.map do |day|
      self.class.find_or_fetch(day)
    end
  end


end

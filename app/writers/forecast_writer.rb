class ForecastWriter
  def find_or_fetch(args)
    @city = args[:city]
    require 'pry'; binding.pry
    return forecast = @city.forecast if forecast
    Forecast.from_service( service, @city )
  end

  private

  def service
    DarkSkyService.new(@city)
  end
end

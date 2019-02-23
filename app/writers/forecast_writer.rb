class ForecastWriter
  def find_or_fetch(args)
    @city = args[:city]
    return forecast = @city.forecast if forecast
    Forecast.from_service( service )
  end

  private

  def service
    DarkSkyService.new(@city)
  end
end

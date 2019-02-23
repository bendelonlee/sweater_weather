class ForecastWriter
  def find_or_fetch(args)
    @city = args[:city]
    if forecast
      forecast
    else
      Forecast.from_service( service, @city )
    end
  end

  private

  def service
    DarkSkyService.new(@city)
  end

  def forecast
    @city.forecast
  end
end

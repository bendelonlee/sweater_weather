class ForecastWriter
  def find_or_fetch(city)
    @city = city
    if found_forecast
      found_forecast
    else
      Forecast.from_service( service, @city )
    end
  end

  private

  def service
    DarkSkyService.new(@city)
  end

  def found_forecast
    @city.forecast
  end
end

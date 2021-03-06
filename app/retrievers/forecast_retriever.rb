class ForecastRetriever

  def find_or_fetch_many(cities)
    cities.each do |city|
      find_or_fetch(city)
    end
  end

  def find_or_fetch(city)
    @city = city
    if found_forecast
      found_forecast
    else
      Forecast.from_service( service, @city )
    end
  end

  def refresh_all
    Forecast.destroy_all
    City.all.each do |city|
      Forecast.from_service( service(city), city )
    end
  end

  private

  def service(city = @city)
    DarkSkyService.new(city)
  end

  def found_forecast
    @city.forecast
  end
end

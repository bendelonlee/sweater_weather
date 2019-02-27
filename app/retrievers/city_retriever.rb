class CityRetriever
  def find_or_fetch(city_name)
    @city_name = city_name.strip.capitalize
    return found_city if found_city
    City.create(
      { name: found_name,
        latitude: coordinates[:lat],
        longitude: coordinates[:lng],
        country: country,
        state: state
      }
    )
  end

  private

  def found_city
    @_city ||= find_city
  end

  def find_city
    City.find_by(latitude: coordinates[:lat], longitude: coordinates[:lng])
  end

  def service
    @_service ||= GoogleGeocoderService.new(@city_name)
  end

  def coordinates
    @_coordinates ||= service.coordinates
  end

  def country
    service.country
  end

  def state
    service.state
  end

  def found_name
    service.city
  end
end

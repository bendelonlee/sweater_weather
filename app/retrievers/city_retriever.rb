class CityRetriever
  def find_or_fetch(city_name)
    @city_name = city_name.strip.capitalize
    return found_city if found_city
    create_city
  end

  private

  def create_city
    city = City.create(
      { name: found_name,
        latitude: coordinates[:lat],
        longitude: coordinates[:lng],
        country: country,
        state: state
      }
    )
    City::Name[@city_name] = city.id
    city
  end

  def found_city
    @_city ||= previously_searched_city
    @_city ||= find_city
  end

  def previously_searched_city
    if id = id_from_name
      City.find(id)
    end
  end

  def id_from_name
    City::Name[@city_name]
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

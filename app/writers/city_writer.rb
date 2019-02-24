class CityWriter
  def find_or_fetch(city_name)
    require 'pry'; binding.pry
    @city_name = city_name
    return found_city if found_city
    City.create(
      { name: @city_name,
        latitude: coordinates[:lat],
        longitude: coordinates[:lng]
      }
    )
  end

  private

  def found_city
    @_city ||= City.find_by(name: @city_name)
  end

  def service
    @_service ||= GoogleGeocoderService.new(@city_name)
  end

  def coordinates
    @_coordinates ||= service.coordinates
  end
end

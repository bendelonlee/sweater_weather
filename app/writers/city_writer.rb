class CityWriter
  def find_or_fetch(city_name)
    @city_name = city_name
    return if City.find_by(name: @city_name)
    City.create(
      { name: @city_name,
        latitude: coordinates[:lat],
        longitude: coordinates[:lng]
      }
    )
  end

  def service
    @_service ||= GoogleGeocoderService.new(@city_name)
  end

  def coordinates
    @_coordinates ||= service.coordinates
  end
end

class CitySerializer < ActiveModel::Serializer
  attributes :id,
             :city_name, :state, :country

  def city_name
    object.name
  end
end

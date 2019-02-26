require "rails_helper"

describe 'User adds a favorite' do

  it 'successully' do
    city_1 = create(:city)
    create(:city)
    user = create(:user)
    api_key = WebToken.encode(user.id)
    params = { city_id: city_1.id, api_key: api_key }
    post "/api/v1/favorites", params: params
    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)["success"]).to eq("City #{city_1.id} added to your favorites")
    expect(user.reload.favorite_cities).to eq([city_1])
  end
  describe 'unsuccessfully' do
    scenario 'no key' do
      city_1 = create(:city)

      params = { city_id: city_1.id }
      post "/api/v1/favorites", params: params

      expect(response.code).to eq('401')
    end
    scenario 'incorrect key' do
      city_1 = create(:city)

      params = { city_id: city_1.id, api_key: 'foobar' }
      post "/api/v1/favorites", params: params

      expect(response.code).to eq('401')
    end
  end

end

describe 'User favorite index' do
  it 'successully' do
    VCR.use_cassette('user favorites') do

      city_1 = create(:city, name: "Denver", state: 'CO', latitude: 39.7392, longitude: -104.9903)
      city_2 = create(:city, name: "Chicago", state: 'IL', latitude: 41.8781, longitude: -87.6298)
      user = create(:user)
      user.favorite_cities += [city_1, city_2]
      api_key = WebToken.encode(user.id)
      get "/api/v1/favorites", params: {api_key: api_key}
      parsed_response = JSON.parse(response.body)
      expect(response).to be_successful
      expect(parsed_response.count).to eq(2)

      denver = parsed_response[0]
      chicago = parsed_response[1]

      expect(denver["id"]).to eq(city_1.id)
      expect(denver["name"]).to eq("Denver")
      expect(denver["state"]).to eq("CO")
      expect(denver["country"]).to eq("United States")

      denver_weather = denver["current_weather"]
      expect(denver_weather).to have_key 'icon'
      expect(denver_weather).to have_key 'summary'
      expect(denver_weather).to have_key 'time'
      expect(denver_weather).to have_key 'temperature'
      expect(denver_weather).to have_key 'feels_like'
      expect(denver_weather).to have_key 'humidity'
      expect(denver_weather).to have_key 'visibility'
      expect(denver_weather).to have_key 'uv_index'
      expect(denver_weather.keys.count).to eq(8)


      expect(chicago["id"]).to eq(city_2.id)
      expect(chicago["name"]).to eq(city_2.name)
      expect(chicago["state"]).to eq(city_2.state)
      expect(chicago["country"]).to eq(city_2.country)
    end
  end

  it 'with a missing key' do
    city_1 = create(:city)

    params = { city_id: city_1.id }
    get "/api/v1/favorites", params: params

    expect(response.code).to eq('401')
  end

  scenario 'with an incorrect key' do
    city_1 = create(:city)

    params = { city_id: city_1.id, api_key: 'foobar' }
    get "/api/v1/favorites", params: params

    expect(response.code).to eq('401')
  end
end

describe 'Favorite deletion endpoint' do
  scenario 'successully' do
    city_1 = create(:city, name: "Denvertropolis")
    stub_service
    stub_days
    stub_hours
    ForecastRetriever.new.find_or_fetch(city_1)
    user = create(:user)
    user.favorite_cities << city_1
    api_key = WebToken.encode(user.id)
    params = { city_id: city_1.id, api_key: api_key }
    delete "/api/v1/favorites", params: params
    expect(response.status).to eq(200)
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["id"]).to eq(city_1.id)
    expect(parsed_response["name"]).to eq(city_1.name)
    expect(user.reload.favorite_cities).to eq([])
  end
  scenario 'with a missing key' do
    city_1 = create(:city)

    params = { city_id: city_1.id }
    delete "/api/v1/favorites", params: params

    expect(response.code).to eq('401')
  end

  scenario 'with an incorrect key' do
    city_1 = create(:city)

    params = { city_id: city_1.id, api_key: 'foobar' }
    delete "/api/v1/favorites", params: params

    expect(response.code).to eq('401')
  end
end

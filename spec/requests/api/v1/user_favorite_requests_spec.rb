require "rails_helper"

describe 'User adds a favorite' do

  it 'successully' do
    city_1 = create(:city)
    create(:city)
    user = create(:user)
    api_key = WebToken.encode(user.id)
    params = { city_id: city_1.id, api_key: api_key }
    post "/api/v1/favorites", params: params
    expect(response).to be_successful
    expect(JSON.parse(response.body)["success"]).to eq("City #{city_1.id} added to your favorites")
    expect(user.reload.favorite_cities).to eq([city_1])
  end
  describe 'unsuccessfully' do
    scenario 'no key' do

    end
    scenario 'incorrect key' do

    end
  end

end

describe 'User favorite index' do
  it 'successully' do

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

    expect(denver["id"]).to eq("#{city_1.id}")
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


    expect(chicago["id"]).to eq("#{city_2.id}")
    expect(chicago["name"]).to eq("Chicago")
    expect(chicago["state"]).to eq("IL")
    expect(chicago["country"]).to eq("United States")
  end

end

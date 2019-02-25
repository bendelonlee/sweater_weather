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

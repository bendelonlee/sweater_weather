require "rails_helper"
describe 'background endpoint' do
  it 'returns a background image for your search' do
    # this param will put your string right into the flickr request
    VCR.use_cassette('denver_image') do
      get '/api/v1/background?location=Denver,CO'

    end

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to have_key(:source)
    expect(result.keys.count).to eq(1)
    # it should not make a request to flickr if it has the image stored
    flickrservice = spy("FlickrService")
    stub_const("FlickrService", flickrservice)
    get '/api/v1/background?location=Denver,CO'

    expect(FlickrService).to_not have_received(:new)
  end
  # xit 'returns a background image for a specific city' do
  #   city = create(:city)
  #   # this will get an image related to the current weather and time of day in that city
  #   VCR.use_cassette('denver_image') do
  #     get '/api/v1/backgrounds?city=Denver,CO'
  #   end
  #
  #   expect(response).to be_successful
  #   result = JSON.parse(response.body, symbolize_names: true)
  #   expect(result).to have_key(:source)
  # end
end

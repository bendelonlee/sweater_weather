require "rails_helper"
describe 'gif endpoint' do
  it 'returns a gif related to the weather of a city' do
    # this param will put your string right into the gif request
    VCR.use_cassette('denver_image') do
      get '/api/v1/gifs?location=Denver,CO'
    end

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to have_key(:days)

    days = result[:days]

    expect(days).to be_a(Array)
    expect(days.first).to have_key(:time)
    expect(days.first).to have_key(:summary)
    expect(days.first).to have_key(:gif_url)
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

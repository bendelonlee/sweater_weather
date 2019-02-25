require "rails_helper"
describe 'gif endpoint' do
  it 'returns a gif related to the weather of a city' do
    # this param will put your string right into the gif request
    VCR.use_cassette('gif_request') do
      get '/api/v1/gifs?location=Denver,CO'
    end

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:copyright]).to eq(2019)
    expect(result).to have_key(:data)
    data = result[:data]
    days = data[:days]

    expect(days).to be_a(Array)
    expect(days.first).to have_key(:time)
    expect(days.first).to have_key(:summary)
    expect(days.first).to have_key(:gif_url)
  end
end

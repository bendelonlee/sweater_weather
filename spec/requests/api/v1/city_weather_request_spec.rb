require "rails_helper"

describe 'customer relationship requests' do
  it "returns today's high, low and current" do
    VCR.use_cassette('denver_weather') do
      VCR.use_cassette('denver_geocode') do
        get "/api/v1/forecast?location=Denver"
      end
    end

    expect(response).to be_successful
    returned_temperature = JSON.parse(response.body)["data"]["temperatures_today"]

    expect(returned_weather).to have_key("high")
    expect(returned_weather).to have_key("low")
    expect(returned_weather).to have_key("current")
  end
end

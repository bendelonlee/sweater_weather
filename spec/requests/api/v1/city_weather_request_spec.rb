require "rails_helper"

describe 'customer relationship requests' do
  it "returns today's high, low and current" do
    get "/api/v1/weather_report/city?=Denver"
    expect(response).to be_successful

    returned_temperature = JSON.parse(response.body)["data"]["temperatures_today"]

    expect(returned_weather).to have_key("high")
    expect(returned_weather).to have_key("low")
    expect(returned_weather).to have_key("current")
  end
  
end

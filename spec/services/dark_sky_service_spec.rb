require "rails_helper"

describe DarkSkyService do
  before(:each) do
    @service = DarkSkyService.new(37.8267, -122.4233)
    VCR.insert_cassette('DarkSkyService')
  end
  after(:each) do
    VCR.eject_cassette('DarkSkyService')
  end

  it 'summaries' do
    expect(@service.day_summary).to be_a(String)
    expect(@service.week_summary).to be_a(String)
  end

  it '.weather_at_hour(integer)' do
    response = @service.weather_at_hour(48)
    expect(response).to be_a(Hash)
    expect(response).to have_key(:icon)
    expect(response).to have_key(:summary)
    expect(response).to have_key(:time)
    expect(response).to have_key(:temperature)
    expect(response).to have_key(:apparentTemperature)
    expect(response).to have_key(:humidity)
    expect(response).to have_key(:visibility)
    expect(response).to have_key(:uvIndex)
  end

  it '.weather_at_day(integer)' do
    response = @service.weather_at_day(7)
    expect(response).to be_a(Hash)
    expect(response).to have_key(:icon)
    expect(response).to have_key(:summary)
    expect(response).to have_key(:time)
    expect(response).to have_key(:temperatureHigh)
    expect(response).to have_key(:temperatureLow)
    expect(response).to have_key(:precipProbability)
    expect(response).to have_key(:precipType)
  end
end

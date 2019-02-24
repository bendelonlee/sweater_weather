require "rails_helper"

describe 'customer relationship requests' do
  it "returns today's high, low and current" do
    VCR.use_cassette('denver_weather') do
      VCR.use_cassette('denver_geocode') do
        get "/api/v1/forecast?location=Denver"
      end
    end

    expect(response).to be_successful
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)

    expect(result).to have_key(:id)
    expect(result).to have_key(:city)
    expect(result).to have_key(:day_summary)
    expect(result).to have_key(:week_summary)
    expect(result).to have_key(:current_hour)
    expect(result).to have_key(:current_day)
    expect(result).to have_key(:hours)
    expect(result).to have_key(:days)
    expect(result.keys.count).to eq(8)

    city = result[:city]
    current_hour = result[:current_hour]
    current_day = result[:current_day]
    hours = result[:hours]
    days = result[:days]

    expect(city).to have_key(:id)
    expect(city).to have_key(:city_name)
    expect(city).to have_key(:state)
    expect(city).to have_key(:country)
    expect(city.keys.count).to eq(4)


    expect(current_hour).to have_key :icon
    expect(current_hour).to have_key :summary
    expect(current_hour).to have_key :time
    expect(current_hour).to have_key :temperature
    expect(current_hour).to have_key :feels_like
    expect(current_hour).to have_key :humidity
    expect(current_hour).to have_key :visibility
    expect(current_hour).to have_key :uv_index
    expect(current_hour.keys.count).to eq(8)

    expect(current_day).to have_key :icon
    expect(current_day).to have_key :summary
    expect(current_day).to have_key :time
    expect(current_day).to have_key :high
    expect(current_day).to have_key :low
    expect(current_day).to have_key :precip_probability
    expect(current_day).to have_key :precip_type
    expect(current_day.keys.count).to eq(7)

    expect(hours).to be_a(Array)
    expect(hours.count).to be_between(8, 25)
    expect(hours.first).to have_key :temperature
    expect(hours.first).to have_key :time_of_day
    expect(hours.first.keys.count).to eq(2)

    expect(days).to be_a(Array)
    expect(days.count).to be_between(7, 8)
    expect(days.first).to have_key :icon
    expect(days.first).to have_key :day_of_week
    expect(days.first).to have_key :high
    expect(days.first).to have_key :low
    expect(days.first).to have_key :precip_probability
    expect(days.first).to have_key :precip_type
    expect(days.first.keys.count).to eq(6)
  end
end

require "rails_helper"

describe GiphyService do
  it ".get_gif" do
    VCR.use_cassette('GiphyService') do
      day = Forecast::Day.new(summary: "Cloudy", time: Date.today, icon: "cloud-day")
      city = create(:city, name: "Denver")
      service = GiphyService.new(forecast_child: day, city: city)
      response = service.gif_data
      expect(response).to be_a(Hash)
      expect(response).to have_key(:gif_url)
      expect(response[:time]).to eq(Date.today)
      expect(response[:summary]).to eq("Cloudy")
    end
  end
end

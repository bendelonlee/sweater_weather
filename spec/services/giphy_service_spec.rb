require "rails_helper"

describe GiphyService do
  it ".get_gif" do
    VCR.use_cassette('GiphyService') do
      day = Forecast::Day.new(summary: "Cloudy", time: Date.today)
      city = create(name: "Denver")
      response = GiphyService.get_gif(forecast_child: day, city: city)
      expect(response).to be_a(Hash)
      expect(response).to have_key(:gif_url)
      expect(response[:time]).to eq(Date.today)
      expect(response[:summary]).to eq("Cloudy")
    end
  end
end

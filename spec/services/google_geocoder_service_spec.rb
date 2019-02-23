require "rails_helper"

describe GoogleGeocoderService do
  it ".coordinates" do
    service = GoogleGeocoderService.new

    expect(service.coordinates('denver')).to be_a(Hash)
    expect(service.coordinates('denver')[:results]).to be_a(Array)
    expect(service.coordinates('denver')[:results]).to have_key(:lat)
    expect(service.coordinates('denver')[:results]).to have_key(:lng)
  end
end

require "rails_helper"

describe GoogleGeocoderService do
  it ".coordinates" do
    service = GoogleGeocoderService.new

    expect(service.coordinates).to be_a(Hash)
    expect(service.coordinates[:results]).to be_a(Array)
    expect(service.coordinates[:results]).to have_key(:lat)
    expect(service.coordinates[:results]).to have_key(:lng)
  end
end

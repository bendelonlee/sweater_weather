require "rails_helper"

describe GoogleGeocoderService do
  it ".coordinates" do
    service = GoogleGeocoderService.new('denver')
    response = service.coordinates
    expect(response).to be_a(Hash)
    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)
  end
end

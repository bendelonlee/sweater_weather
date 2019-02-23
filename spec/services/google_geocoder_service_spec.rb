require "rails_helper"

describe GoogleGeocoderService do
  it ".coordinates" do
    service = GoogleGeocoderService.new('denver')
    response = service.coordinates
    expect(response).to be_a(Hash)
    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)
  end
  it 'city' do
    service = GoogleGeocoderService.new('denver')
    expect(service.city).to eq("Denver")
  end
  it 'state' do
    service = GoogleGeocoderService.new('denver')
    expect(service.state).to eq("CO")
  end
  it 'country' do
    service = GoogleGeocoderService.new('denver')
    expect(service.country).to eq("United States")
  end
end

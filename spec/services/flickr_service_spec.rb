require "rails_helper"

describe FlickrService do
  it ".coordinates" do
    VCR.use_cassette('Flicker') do
      service = FlickrService.new('denver,CO')
      response = service.image_source
      expect(response).to be_a(String)
    end
  end
end

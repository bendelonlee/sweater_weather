require "rails_helper"

describe CityWriter do
  describe ".create_if_unfound" do
    before(:each) do
      @latitude = 123.22
      @longitude = -111.45
      @city_name = "Denvertropolis"
      service_class = double("geo_service_class")
      service       = double("geo_service")
      stub_const("GoogleGeocoderService", service_class )
      expect(service_class).to receive(:new).and_return( service )
      expect(service).to receive(:coordinates).with(@city_name) do
        { lat: @latitude, lng: @longitude }
      end
    end
    it "creates" do
      city = create(:city)
      writer = CityWriter.new
      writer.create_if_unfound(@city_name)
      expect(City.count).to eq(2)
      expect(City.last.latitude).to eq(@latitude)
      expect(City.last.longitude).to eq(@longitude)
    end
    describe "does not create" do
      before(:each) do
        create(:city, name: @city_name, latitude: @latitude, longitude: @longitude)
      end
      scenario "when the name is already taken" do
        @city_to_find = @city_name
      end
      after(:each) do
        writer = CityWriter.new
        writer.create_if_unfound(@city_to_find)
        expect(City.count).to eq(1)
      end
    end
  end
end

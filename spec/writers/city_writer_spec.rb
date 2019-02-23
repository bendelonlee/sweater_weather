require "rails_helper"

describe CityWriter do
  describe ".find_or_create_by_city" do
    before(:each) do
      @latitude  = 123.22
      @longitude = -111.45
      @city_name = "Denvertropolis"
      @service_class = spy("GoogleGeocoderService")
      @service       = spy("geo_service")
      stub_const("GoogleGeocoderService", @service_class )
      allow(@service_class).to receive(:new).and_return( @service )
      allow(@service).to receive(:coordinates).with(@city_name) do
        { lat: @latitude, lng: @longitude }
      end
    end
    it "creates" do
      create(:city)
      writer = CityWriter.new
      writer.find_or_create_by_city(@city_name)
      expect(City.count).to eq(2)
      expect(City.last.latitude).to eq(@latitude)
      expect(City.last.longitude).to eq(@longitude)
      expect(@service_class).to have_received(:new)
      expect(@service).to have_received(:coordinates)
    end
    describe "finds" do
      before(:each) do
        create(:city, name: @city_name, latitude: @latitude, longitude: @longitude)
      end
      scenario "when the name is already taken" do
        @city_to_find = @city_name
      end
      after(:each) do
        writer = CityWriter.new
        writer.find_or_create_by_city(@city_to_find)
        expect(City.count).to eq(1)
        expect(@service).to_not have_received(:coordinates)
        expect(@service_class).to_not have_received(:new)
      end
      #refactor. Given "Paris" when "Paris Texas" and "Paris France" are in the database, it should find the more popular (france). But, given "Paris, Texas", it should find the right one
    end
  end
end

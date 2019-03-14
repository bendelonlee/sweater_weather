require "rails_helper"

describe CityRetriever do
  describe ".find_or_fetch" do
    before(:each) do
      @latitude  = 39.7392
      @longitude = -104.9903
      @city_name = "Denvertropolis"
      @service_class = spy("GoogleGeocoderService")
      @service       = spy("geo_service")
      stub_const("GoogleGeocoderService", @service_class )
      allow(@service_class).to receive(:new).and_return( @service )
      allow(@service).to receive_messages(
        coordinates:
        { lat: @latitude, lng: @longitude },
        city: "Denvertropolis",
        state: "CO",
        country: "United States"
      )
    end
    it "creates" do
      VCR.use_cassette("timezone") do
        create(:city)
        retriever = CityRetriever.new
        retriever.find_or_fetch(@city_name)
        # expect(City.count).to eq(2)
        expect(City.last.latitude).to eq(@latitude)
        expect(City.last.longitude).to eq(@longitude)
        expect(City.last.timezone_offset).to eq(-21600)
        expect(@service_class).to have_received(:new)
        expect(@service).to have_received(:coordinates)
      end
    end
    describe "finds" do
      before(:each) do
        $redis.redis.flushdb
        city = create(:city, name: @city_name, latitude: @latitude, longitude: @longitude)
        City::Name[@city_name] = city.id
      end
      scenario "when the name is already taken" do
        @city_to_find = @city_name
      end
      after(:each) do
        retriever = CityRetriever.new
        found_city = retriever.find_or_fetch(@city_to_find)
        expect(City.count).to eq(1)
        expect(@service).to_not have_received(:coordinates)
        expect(@service_class).to_not have_received(:new)
        expect(found_city).to be_a(City)
        expect(found_city.name).to eq(@city_to_find)
      end
    end
  end
end

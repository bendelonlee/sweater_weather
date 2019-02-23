require "rails_helper"

describe WeatherWriter do
  describe ".find_or_create_by_city" do
    before(:each) do
      @city_name = "Denvertropolis"
      @service_class = spy("WeatherService")
      @service       = spy("weather_service")
      stub_const("DarkSkyService", @service_class )
      allow(@service_class).to receive(:new).and_return( @service )
      @service.stub(
        coordinates:
          { lat: @latitude, lng: @longitude },
        city: "Denvertropolis",
        state: "Colorado",
        country: "United States"
      )
      end
    end
    it "creates" do
      create(:weather)
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
      #Another refactor: It should store which searches led to which cities. EG, 123 maple street is in the Metropolis, the next time that address is looked for it should default Metropolis
    end
  end
end
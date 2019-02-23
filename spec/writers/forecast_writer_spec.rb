require "rails_helper"

describe ForecastWriter do
  include ForecastSpecHelpers
  describe ".find_or_fetch" do
    before(:each) do
      stub_service
    end
    describe "it find" do
      describe "the hour's weather" do
        scenario 'when the forecast was retrieved this hour' do
          expect do
            writer = ForecastWriter.new
            writer.find_or_fetch(city: @city)
          end.to change{Forecast.count}.from(0).to(1)
        end
        scenario 'when the forecast was retrieved earlier' do

        end
      end
    end
  end
end

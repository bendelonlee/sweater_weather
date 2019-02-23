require "rails_helper"
#Refactor: To cut down on write time, I could switch to storing the weather data as a jsonb column on the forecast table and switch to making the day and hour POROs
describe Forecast::Day do
  describe 'class methods' do
    include ForecastSpecHelpers
    it '.from_hash' do
      dh= day_hash
      day = Forecast::Day.from_hash(dh)
      expect(day.icon).to               eq(dh[:icon])
      expect(day.summary).to            eq(dh[:summary])
      expect(day.time).to               eq(Time.strptime(dh[:time], '%s'))
      expect(day.high).to               eq(dh[:temperatureHigh])
      expect(day.low).to                eq(dh[:temperatureLow])
      expect(day.precip_probability).to eq(dh[:precipProbability])
      expect(day.precip_type).to        eq(dh[:precipType])
    end
  end
end

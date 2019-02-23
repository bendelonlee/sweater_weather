require "rails_helper"

describe Forecast::Hour do
  describe 'class methods' do
    include ForecastSpecHelpers
    it '.from_hash' do
      hh= hour_hash
      hour = Forecast::Hour.from_hash(hh)
      expect(hour.icon).to        eq(hh[:icon])
      expect(hour.summary).to     eq(hh[:summary])
      expect(hour.time).to        eq(Time.strptime(hh[:time], '%s'))
      expect(hour.tempurature).to eq(hh[:temperature])
      expect(hour.feels_like).to  eq(hh[:apparentTemperature])
      expect(hour.humidity).to    eq(hh[:humidity])
      expect(hour.visibility).to  eq(hh[:visibility])
      expect(hour.uv_index).to    eq(hh[:uvIndex])
    end
  end
end

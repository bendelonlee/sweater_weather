require "rails_helper"

describe Forecast::Hour do
  describe 'class methods' do
    include ForecastSpecHelpers
    it '.from_hash' do
      hh= hour_hash
      hour = Forecast::Hour.new(hh, 0)
      expect(hour.icon).to        eq(hh[:icon])
      expect(hour.summary).to     eq(hh[:summary])
      expect(hour.time).to        eq(DateTime.strptime(hh[:time].to_s, '%s'))
      expect(hour.temperature).to eq(hh[:temperature])
      expect(hour.feels_like).to  eq(hh[:apparentTemperature])
      expect(hour.humidity).to    eq(hh[:humidity])
      expect(hour.visibility).to  eq(hh[:visibility])
      expect(hour.uv_index).to    eq(hh[:uvIndex])
    end
  end
end

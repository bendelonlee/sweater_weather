class Forecast::Hour < ApplicationRecord
  def self.from_hash(hash)
    create(
      icon:          hash[:icon],
      summary:       hash[:summary],
      time:          DateTime.strptime(hash[:time], '%s'),
      tempurature:   hash[:temperature],
      feels_like:    hash[:apparentTemperature],
      humidity:      hash[:humidity],
      visibility:    hash[:visibility],
      uv_index:      hash[:uvIndex]
    )
  end
end

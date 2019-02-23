class Forecast::Day < ApplicationRecord
  def self.from_hash(hash)
    create(
      icon:               hash[:icon],
      summary:            hash[:summary],
      time:               Time.strptime(hash[:time], '%s'),
      high:               hash[:temperatureHigh],
      low:                hash[:temperatureLow],
      precip_probability: hash[:precipProbability],
      precip_type:        hash[:precipType]
    )
  end
end

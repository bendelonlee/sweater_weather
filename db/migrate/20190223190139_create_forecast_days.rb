class CreateForecastDays < ActiveRecord::Migration[5.1]
  def change
    create_table :forecast_days do |t|
      t.string :icon
      t.string :summary
      t.string :time
      t.decimal :high
      t.decimal :low
      t.decimal :precip_probability
      t.string :precip_type

      t.timestamps
    end
  end
end

class CreateWeatherHours < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_hours do |t|
      t.string :icon
      t.string :summary
      t.datetime :time
      t.decimal :tempurature
      t.decimal :feels_like
      t.d :humidity

      t.timestamps
    end
  end
end

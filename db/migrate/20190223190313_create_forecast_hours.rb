class CreateForecastHours < ActiveRecord::Migration[5.1]
  def change
    create_table :forecast_hours do |t|
      t.string :icon
      t.string :summary
      t.datetime :time
      t.decimal :tempurature
      t.decimal :feels_like
      t.decimal :humidity
      t.decimal :visibility
      t.integer :uv_index

      t.timestamps
    end
  end
end

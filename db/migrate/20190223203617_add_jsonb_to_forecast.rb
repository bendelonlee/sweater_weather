class AddJsonbToForecast < ActiveRecord::Migration[5.1]
  def change
    add_column :forecasts, :days_data, :jsonb
    add_column :forecasts, :hours_data, :jsonb
  end
end

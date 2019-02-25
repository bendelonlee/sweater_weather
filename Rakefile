# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task refresh_forecasts: :environment do
  forecast_writer = ForecastWriter.new
  time_taken = Benchmark.measure do
    forecast_writer.refresh_all
  end
  "Refreshed all #{Forecast.count} forecasts with benchmark: \n #{time_taken}"
end

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task refresh_forecasts: :environment do
  forecast_retriever = ForecastRetriever.new
  time_taken = Benchmark.measure do
    forecast_retriever.refresh_all
  end

  puts "Refreshed all #{Forecast.count} forecasts in \n #{time_taken.real} seconds"
end

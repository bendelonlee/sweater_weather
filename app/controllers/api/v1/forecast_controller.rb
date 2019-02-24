class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastSerializer.new(forecast)
  end

  private

  def forecast
    forecast_writer.find_or_fetch(city)
  end

  def city
    city_writer.find_or_fetch(params[:location])
  end

  def city_writer
    CityWriter.new
  end

  def forecast_writer
    ForecastWriter.new
  end
end

class Api::V1::GifsController < ApplicationController
  def show
    render json: gif_forecast
  end


  private

  def gif_forecast
    GifWriter.new(forecast).days
  end

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

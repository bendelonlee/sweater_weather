class Api::V1::GifsController < ApplicationController
  def show
    render json: {
                data: GifsSerializer.new(gif_forecast_days_simple),
                copyright: Date.today.year
              }
  end

  private

  def gif_forecast_days_simple
    Gif::Simple.from_gifs(gif_forecast_days)
  end

  def gif_forecast_days
    @_days = GifRetriever.new(forecast).days
  end

  def forecast
    forecast_retriever.find_or_fetch(city)
  end

  def city
    city_retriever.find_or_fetch(params[:location])
  end

  def city_retriever
    CityRetriever.new
  end

  def forecast_retriever
    ForecastRetriever.new
  end
end

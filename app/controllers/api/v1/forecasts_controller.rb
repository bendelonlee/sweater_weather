class Api::V1::ForecastsController < ApplicationController
  def show
    render json: forecast, each_serializer: Forecast::HourSerializer
  end

  private

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

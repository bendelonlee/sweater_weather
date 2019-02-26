class Api::V1::FavoritesController < ApplicationController
  before_action :require_valid_api_key

  def create
    user.favorite_cities << city
    render json: { success: "City #{city.id} added to your favorites"}, status: 201
  end

  def index
    retriever.find_or_fetch_many(user_cities)
    render json: user_cities, each_serializer: Forecast::CurrentSerializer
  end

  private

  def require_valid_api_key
    begin
      user
    rescue
      render json: {'Warning': 'Unauthorized'}, status: 401
    end
  end

  def user_cities
    @_user_cities ||= user.favorite_cities.includes(:forecast)
  end

  def favorite_params
    params.permit(:city_id, :api_key)
  end

  def user
    User.find(user_id)
  end

  def user_id
    @_user_id ||= WebToken.decode(favorite_params[:api_key])
  end

  def city
    @_city ||= City.find(favorite_params[:city_id])
  end

  def retriever
    ForecastRetriever.new
  end
end

class Api::V1::FavoritesController < ApplicationController
  def create
    user
    render json: { success: "City #{city.id} added to your favorites"}
  end

  def favorite_params
    params.permit(:city_id, :api_key)
  end

  def user
    User.find(WebToken.decode(favorite_params[:api_key]))
  end

  def city
    @_city ||= City.find(favorite_params[:city_id])
  end
end

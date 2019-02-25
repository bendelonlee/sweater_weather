class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    api_key = WebToken.encode(user.id)
    render json: {
      api_key: api_key
    }
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

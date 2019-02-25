class Api::V1::SessionsController < ApplicationController
  def create
    if user && user.authenticate(user_params[:password])
      render json: {api_key: WebToken.encode(user.id)}
    end
  end

  private

  def user
    @_user ||= User.find_by(email: user_params[:email])
  end

  def user_params
    params.permit(:email, :password)
  end
end

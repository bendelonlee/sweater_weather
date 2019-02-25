class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    render json: {
      api_key: Digest::SHA1.hexdigest([user.id, Time.now, Rails.application.secrets.secret_key_base].join(':'))
    }
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

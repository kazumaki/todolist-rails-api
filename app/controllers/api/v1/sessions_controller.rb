class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])

    unless @user
      head :unprocessable_entity
      return
    end

    if @user.authenticate(user_params[:password])
      secret_key = Rails.application.secrets.secret_key_base.to_s
      token = JWT.encode({user_id: @user.id}, secret_key)
      render json: { user: @user, token: token }, status: :created
    else
      head :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

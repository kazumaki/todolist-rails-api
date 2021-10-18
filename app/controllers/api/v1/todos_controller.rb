class Api::V1::TodosController < ApplicationController

  before_action :authenticate, only: %i[index]

  def index
    render json: @current_user.todos, status: :ok
  end

  private
  def authenticate
    token = request.headers['Authorization']
    secret_key = Rails.application.secrets.secret_key_base.to_s

    begin
      user_id = HashWithIndifferentAccess.new(JWT.decode(token, secret_key)[0])[:user_id]
      @current_user = User.find(user_id)
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

end

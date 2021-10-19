class Api::V1::TodosController < ApplicationController

  before_action :authenticate, only: %i[index create]

  def index
    render json: @current_user.todos, status: :ok
  end

  def create
    @todo = @current_user.todos.new(todo_params)

    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:name)
  end

  def authenticate
    token = request.headers['Authorization']
    secret_key = Rails.application.secrets.secret_key_base.to_s

    begin
      user_id = HashWithIndifferentAccess.new(JWT.decode(token, secret_key)[0])[:user_id]
      @current_user = User.find(user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound   => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

end

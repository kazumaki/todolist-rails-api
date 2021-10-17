class Api::V1::TodosController < ApplicationController

  def index
    @user = User.first

    unless @user
      head :unauthorized
      return
    end

    render json: @user.todos, status: :ok
  end

end

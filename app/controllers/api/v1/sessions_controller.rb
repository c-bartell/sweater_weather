class Api::V1::SessionsController < ApplicationController
  def create
    if user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    end
  end

  private

  def user
    @user ||= User.find_by(email: params[:email])
  end
end

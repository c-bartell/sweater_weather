class Api::V1::SessionsController < ApplicationController
  def create
    if user && user.authenticate(params[:password])

      render json: UserSerializer.new(user)
    else

      render json: { errors: ['Invalid credentials'] }, status: :bad_request
    end
  end

  private

  def user
    @user ||= User.find_by(email: params[:email])
  end
end

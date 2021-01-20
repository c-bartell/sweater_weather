class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.save
    payload = {
      data: {
        type: 'users',
        id: @user.id,
        attributes: {
          email: @user.email,
          api_key: @user.api_key
        }
      }
    }
    # binding.pry
    render json: payload, status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

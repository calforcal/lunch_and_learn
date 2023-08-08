class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    user.update!(api_key: SecureRandom.urlsafe_base64)
    render json: UserSerializer.new(user), status: :created
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
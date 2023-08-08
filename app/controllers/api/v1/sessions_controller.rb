class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
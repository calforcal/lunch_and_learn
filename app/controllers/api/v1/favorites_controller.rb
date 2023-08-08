class Api::V1::FavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      render json: FavoriteSerializer.new(user.favorites)
    else
      render json: { error: 'Unauthorized request, please try again.' }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      user.favorites.create!(favorite_params)
      render json: { success: "Favorite added successfully" }, status: :created
    else
      render json: { error: 'Unauthorized request, please try again.' }, status: :unauthorized
    end
  end

  private
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
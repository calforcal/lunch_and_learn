class Api::V1::RecipesController < ApplicationController
  def index
    render json: RecipeSerializer.new(RecipesFacade.new.recipes_index(params[:country]))
  end
end
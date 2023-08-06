class Api::V1::LearningResourcesController < ApplicationController
  def index
    render json: LearningResourceSerializer.new(LearningResourcesFacade.new.learning_resources_index(params[:country]))
  end
end
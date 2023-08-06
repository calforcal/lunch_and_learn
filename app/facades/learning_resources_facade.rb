class LearningResourcesFacade
  def learning_resources_index(search)
    video_details = youtube_service.movie_info(search)
    images_details = pexel_service.images_by_country(search)
    images_array = images_details[:photos].slice(0,10)
    video = YoutubeMedia.new(video_details[:items].first).as_json
    images = images_array.map { |image| Pexel.new(image).as_json }
    @resource = LearningResource.new(search, video, images)
  end

  def youtube_service
    YoutubeMediaService.new
  end

  def pexel_service
    PexelsService.new
  end
end
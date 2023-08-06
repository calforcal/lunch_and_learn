class YoutubeMedia
  attr_reader :title, :youtube_video_id

  def initialize(details)
    @title = details[:snippet][:title]
    @youtube_video_id = details[:id][:videoId]
  end
end
class YoutubeMedia
  attr_reader :title, :youtube_video_id

  def initialize(details)
    @title = if details == nil then nil else details[:snippet][:title] end
    @youtube_video_id = if details == nil then nil else details[:id][:videoId] end
  end
end
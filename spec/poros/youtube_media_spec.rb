require 'rails_helper'

RSpec.describe YoutubeMedia do
  it "exists" do
    attrs = {
      snippet: {
        title: "Youtube"
      },
      id: {
        videoId: "ABC"
      }
    }

    video = YoutubeMedia.new(attrs)

    expect(video.title).to eq(attrs[:snippet][:title])
    expect(video.youtube_video_id).to eq(attrs[:id][:videoId])
  end
end
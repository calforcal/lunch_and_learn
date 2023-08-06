require 'rails_helper'

RSpec.describe YoutubeMediaService do
  describe "#movie_info" do
    it "can get educational video info by country" do
      search = "singapore"
      response = YoutubeMediaService.new.movie_info(search)

      expect(response).to have_key(:items)
      expect(response[:items]).to be_an Array

      video = response[:items].first

      expect(video).to have_key(:id)
      expect(video[:id]).to be_a Hash

      expect(video[:id]).to have_key(:videoId)
      expect(video[:id][:videoId]).to be_a String

      expect(video[:snippet]).to have_key(:title)
      expect(video[:snippet][:title]).to be_a String

      expect(video).to have_key(:etag)
      expect(video).to have_key(:kind)
    end
  end
end
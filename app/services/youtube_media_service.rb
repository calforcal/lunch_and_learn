class YoutubeMediaService
  def movie_info(search)
    get_url("search?q=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://youtube.googleapis.com/youtube/v3/') do |faraday|
      faraday.headers['Accept'] = 'application/json'
      faraday.params['key'] = ENV['YOUTUBE_API_KEY']
      faraday.params['part'] = 'snippet'
      faraday.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
  end
end
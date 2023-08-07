class AirQualityService
  def get_air_quality_info(search)
    get_url("airquality?city=#{search.name}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    Faraday.new('https://api.api-ninjas.com/v1/') do |faraday|
      faraday.headers['x-api-key'] = ENV['API_NINJAS_KEY']
    end
  end
end
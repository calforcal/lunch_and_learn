class RecipesService
  def recipes_by_country(search)
    get_url("/api/recipes/v2?q=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.edamam.com') do |faraday|
      faraday.params['app_id'] = ENV['EDAMAM_APP_ID']
      faraday.params['app_key'] = ENV['EDAMAM_APP_KEY']
      faraday.params['type'] = 'public'
    end
  end
end
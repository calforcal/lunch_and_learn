class CountriesService
  def get_all_countries
    get_url('all')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://restcountries.com/v3.1/')
  end
end
class CountriesFacade
  def countries_index
    details = service.get_all_countries
    details.map { |result| Country.new(result) }
  end

  def countries_city(search)
    details = service.get_countries_city(search)
    City.new(details.first)
  end

  def service
    CountriesService.new
  end
end
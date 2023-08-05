class CountriesFacade
  def countries_index
    details = service.get_all_countries
    details.map { |result| Country.new(result) }
  end

  def service
    CountriesService.new
  end
end
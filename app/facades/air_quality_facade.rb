class AirQualityFacade
  def air_quality_by_city(search)
    city = CountriesFacade.new.countries_city(search)

    details = service.get_air_quality_info(city)
    AirQuality.new(details, city)
  end

  def service
    AirQualityService.new
  end
end
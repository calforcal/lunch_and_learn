class AirQuality
  attr_reader :id, :aqi, :pm25_concentration, :co_concentration, :city

  def initialize(details, city)
    @id = nil
    @aqi = details[:"overall_aqi"]
    @pm25_concentration = details[:"PM2.5"][:"concentration"]
    @co_concentration = details[:"CO"][:"concentration"]
    @city = city.name
  end
end
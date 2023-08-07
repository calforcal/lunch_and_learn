class Api::V1::AirQualityController < ApplicationController
  def index
    # render json: AirQualitySerializer.new(AirQualityFacade.new.air_quality_by_city(params[:country])).as_json(city: params[:country])
    air_quality = AirQualityFacade.new.air_quality_by_city(params[:country])

    render json: {
      "data": {
        "id": nil,
        "type": "air_quality",
        "city": CountriesFacade.new.countries_city(params[:country]).name,
        "attributes": {
          aqi: air_quality.aqi,
          pm25_concentration: air_quality.pm25_concentration,
          co_concentration: air_quality.co_concentration
        }
      }
    }
  end
end
require 'rails_helper'

RSpec.describe AirQualityFacade do
  describe "air_quality_by_city" do
    it "gets an air quality object for a given city" do

      air_quality = AirQualityFacade.new.air_quality_by_city("Nigeria")

      expect(air_quality).to be_an AirQuality

      expect(air_quality.aqi).to be_an Integer
      expect(air_quality.pm25_concentration).to be_a Float
      expect(air_quality.co_concentration).to be_a Float
      expect(air_quality.city).to be_a String
    end
  end
end
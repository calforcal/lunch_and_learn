require 'rails_helper'

RSpec.describe 'AirQualityService' do
  describe "#get_air_quality_info" do
    it "can receive a city and return its Air Quality info" do
      city = City.new({capital: ['Abuja']})
      service = AirQualityService.new
      search = service.get_air_quality_info(city)

      expect(search).to have_key(:CO)
      expect(search[:CO]).to be_a Hash
      expect(search[:CO]).to have_key(:concentration)
      expect(search[:CO][:concentration]).to be_a Float
      expect(search[:CO]).to have_key(:aqi)
      expect(search[:CO][:aqi]).to be_a Integer

      expect(search[:"PM2.5"]).to be_a Hash
      expect(search[:"PM2.5"]).to have_key(:concentration)
      expect(search[:"PM2.5"][:concentration]).to be_a Float
      expect(search[:"PM2.5"]).to have_key(:aqi)
      expect(search[:"PM2.5"][:aqi]).to be_a Integer

      expect(search[:NO2]).to be_a Hash
      expect(search[:NO2]).to have_key(:concentration)
      expect(search[:NO2][:concentration]).to be_a Float
      expect(search[:NO2]).to have_key(:aqi)
      expect(search[:NO2][:aqi]).to be_a Integer

      expect(search[:overall_aqi]).to be_a Integer
    end
  end
end
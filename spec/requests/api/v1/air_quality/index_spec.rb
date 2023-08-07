require 'rails_helper'

RSpec.describe 'AirQuality' do
  describe "Get Air Quaility for Capital City" do
    describe "happy paths" do
      it "can get the air quality for a given countries capital city" do
        get api_v1_air_quality_index_path(country: "Nigeria")

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed).to have_key(:data)
        expect(parsed[:data]).to be_a Hash

        air_quality = parsed[:data]

        expect(air_quality).to have_key(:id)
        expect(air_quality[:id]).to eq(nil)

        expect(air_quality).to have_key(:type)
        expect(air_quality[:type]).to be_a String
        expect(air_quality[:type]).to eq("air_quality")

        expect(air_quality).to have_key(:city)
        expect(air_quality[:city]).to be_a String

        expect(air_quality).to have_key(:attributes)
        expect(air_quality[:attributes]).to be_a Hash

        expect(air_quality[:attributes]).to have_key(:aqi)
        expect(air_quality[:attributes][:aqi]).to be_an Integer

        expect(air_quality[:attributes]).to have_key(:pm25_concentration)
        expect(air_quality[:attributes][:pm25_concentration]).to be_an Float

        expect(air_quality[:attributes]).to have_key(:co_concentration)
        expect(air_quality[:attributes][:co_concentration]).to be_an Float
      end
    end
  end
end
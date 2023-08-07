require 'rails_helper'

RSpec.describe AirQuality do
  it "exists" do
    city = City.new({capital: ['Abuja']})
    attrs = {
      overall_aqi: 25,
      "PM2.5": {
        concentration: 14.14
  },
      "CO": {
        concentration: 25.25
  }
    }

    air_quality = AirQuality.new(attrs, city)

    expect(air_quality.aqi).to eq(attrs[:overall_aqi])
    expect(air_quality.pm25_concentration).to eq(attrs[:"PM2.5"][:concentration])
    expect(air_quality.co_concentration).to eq(attrs[:"CO"][:concentration])
    expect(air_quality.city).to eq(city.name)
  end
end
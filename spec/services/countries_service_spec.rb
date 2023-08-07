require 'rails_helper'

RSpec.describe CountriesService do
  describe "#get_all_countries" do
    it "can get all countries names", :vcr do
      CountriesFacade.new.countries_index
      service = CountriesService.new.get_all_countries

      expect(service).to be_an Array

      service.each do |country|
        expect(country).to be_a Hash
        expect(country).to have_key(:name)
        expect(country[:name]).to be_a Hash

        expect(country[:name]).to have_key(:common)
        expect(country[:name][:common]).to be_a String

        expect(country[:name]).to have_key(:official)
        expect(country[:name][:official]).to be_a String
      end
    end
  end

  describe "#get_countries_city" do
    it "can get a countries city", :vcr do
      service = CountriesService.new.get_countries_city("Nigeria")

      expect(service).to be_an Array

      info = service.first

      expect(info).to have_key(:name)
      expect(info[:name]).to be_a Hash

      expect(info).to have_key(:tld)
      expect(info[:tld]).to be_an Array

      expect(info).to have_key(:status)
      expect(info[:status]).to be_a String

      expect(info).to have_key(:capital)
      expect(info[:capital]).to be_an Array

      expect(info[:capital].first).to be_a String
    end
  end
end
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
end
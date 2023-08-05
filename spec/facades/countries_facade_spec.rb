require 'rails_helper'

RSpec.describe CountriesFacade do
  describe "countries_index" do
    it "gets all countries as objects", :vcr do
      countries = CountriesFacade.new.countries_index

      expect(countries).to be_an Array

      countries.each do |country|
        expect(country).to be_a Country
        expect(country.name).to be_a String
      end
    end
  end
end
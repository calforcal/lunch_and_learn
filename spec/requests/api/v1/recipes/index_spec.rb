require 'rails_helper'

RSpec.describe 'Recipes' do
  describe "Fetch Recipes" do
    describe "By Search" do
      describe "happy paths" do
        it "can get recipes by search", :vcr do
          get api_v1_recipes_path(country: 'thailand')

          expect(response).to be_successful
          
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          recipes = parsed[:data]

          expect(recipes).to be_an Array
          expect(recipes.first).to be_a Hash

          recipes.each do |recipe|
            expect(recipe).to have_key(:id)
            expect(recipe[:id]).to be(nil)

            expect(recipe).to have_key(:type)
            expect(recipe[:type]).to eq('recipe')

            expect(recipe).to have_key(:attributes)
            expect(recipe[:attributes]).to be_a Hash

            expect(recipe[:attributes]).to have_key(:title)
            expect(recipe[:attributes][:title]).to be_a String

            expect(recipe[:attributes]).to have_key(:url)
            expect(recipe[:attributes][:url]).to be_a String

            expect(recipe[:attributes]).to have_key(:country)
            expect(recipe[:attributes][:country]).to be_a String

            expect(recipe[:attributes]).to have_key(:image_url)
            expect(recipe[:attributes][:image_url]).to be_a String
          end
        end
      end
    end
  end
end
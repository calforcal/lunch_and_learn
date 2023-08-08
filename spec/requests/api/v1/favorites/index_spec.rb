require 'rails_helper'

RSpec.describe Favorite do
  describe "Fetch a Users Favorites" do
    before(:each) do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "test",
        "password_confirmation": "test"
      }

      headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      post api_v1_users_path, headers: headers, params: JSON.generate(user_params)

      @user = User.last
      @favorite_1 = @user.favorites.create!(country: "America", recipe_link: "cheeseburger_url", recipe_title: "Yummy Cheeseburger")
      @favorite_2 = @user.favorites.create!(country: "France", recipe_link: "cheesecake_url", recipe_title: "Cheesecake")
    end

    describe "happy paths" do
      it "can get a Users Favorites from their API Key" do
        get api_v1_favorites_path(api_key: @user.api_key)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:data)
        expect(parsed[:data]).to be_an Array

        favorites = parsed[:data]

        favorites.each do |favorite|
          expect(favorite).to be_a Hash
          expect(favorite).to have_key(:id)
          expect(favorite[:id]).to be_a String
          expect(favorite[:id]).to_not be nil

          expect(favorite).to have_key(:type)
          expect(favorite[:type]).to be_a String
          expect(favorite[:type]).to eq("favorite")

          expect(favorite).to have_key(:attributes)
          expect(favorite[:attributes]).to be_a Hash

          expect(favorite[:attributes]).to have_key(:recipe_link)
          expect(favorite[:attributes][:recipe_link]).to be_a String

          expect(favorite[:attributes]).to have_key(:recipe_title)
          expect(favorite[:attributes][:recipe_title]).to be_a String

          expect(favorite[:attributes]).to have_key(:country)
          expect(favorite[:attributes][:country]).to be_a String

          expect(favorite[:attributes]).to have_key(:created_at)
          expect(favorite[:attributes][:created_at]).to be_a String
        end

        expect(favorites[0][:attributes][:recipe_link]).to eq(@favorite_1.recipe_link)
        expect(favorites[0][:attributes][:recipe_title]).to eq(@favorite_1.recipe_title)
        expect(favorites[0][:attributes][:country]).to eq(@favorite_1.country)
      end
    end
  end
end
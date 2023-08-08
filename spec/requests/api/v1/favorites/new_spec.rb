require 'rails_helper'

RSpec.describe 'Favorites' do
  describe "Create a Favorite Recipe" do
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
    end

    describe "happy paths" do
      it "can receive a post request to create a new favorite" do
        expect(@user.favorites.count).to eq(0)

        favorite_params = {
          "api_key": @user.api_key,
          "country": "thailand",
          "recipe_link": "https://hot-thai-kitchen.com/crab-fried-rice-2/",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite_params)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:success)
        expect(parsed[:success]).to eq("Favorite added successfully")

        expect(@user.favorites.count).to eq(1)
      end
    end

    describe "sad paths" do
      it "will produce an error if the api_key is not found" do
        expect(@user.favorites.count).to eq(0)

        favorite_params = {
          "api_key": "XX24XX",
          "country": "thailand",
          "recipe_link": "https://hot-thai-kitchen.com/crab-fried-rice-2/",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:error)
        expect(parsed[:error]).to eq("Unauthorized request, please try again.")

        expect(@user.favorites.count).to eq(0)
      end

      it "will produce an error if information is blank" do
        expect(@user.favorites.count).to eq(0)

        favorite_params = {
          "api_key": "XX24XX",
          "country": "",
          "recipe_link": "https://hot-thai-kitchen.com/crab-fried-rice-2/",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_favorites_path, headers: headers, params: JSON.generate(favorite_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:error)
        expect(parsed[:error]).to eq("Unauthorized request, please try again.")

        expect(@user.favorites.count).to eq(0)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe "Sessions" do
  describe "Log In a User" do
    describe "happy paths" do
      it "can receive a post request to login a User" do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "test",
          "password_confirmation": "test"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_users_path, headers: headers, params: JSON.generate(user_params)

        user_params = {
          "email": "goodboy@ruffruff.com",
          "password": "test"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_sessions_path, headers: headers, params: JSON.generate(user_params)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]

        expect(user).to have_key(:id)
        expect(user[:id]).to be_a String

        expect(user).to have_key(:type)
        expect(user[:type]).to be_a String
        expect(user[:type]).to eq("user")

        expect(user).to have_key(:attributes)
        expect(user[:attributes]).to be_a Hash

        expect(user[:attributes]).to have_key(:name)
        expect(user[:attributes][:name]).to be_a String

        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_a String

        expect(user[:attributes]).to have_key(:api_key)
        expect(user[:attributes][:api_key]).to be_a String
      end
    end
  end
end
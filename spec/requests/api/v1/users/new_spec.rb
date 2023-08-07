require 'rails_helper'

RSpec.describe "Users" do
  describe "Create One User" do
    describe "happy paths" do
      it "can receive a post request and create one user" do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "test",
          "password_confirmation": "test"
        }

        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_users_path, headers: headers, params: JSON.generate(user_params)

        created_user = User.last

        expect(created_user.name).to eq(user_params[:name])
        expect(created_user.email).to eq(user_params[:email])
        expect(created_user.password).to eq(nil)

        expect(response).to be_successful

        user_response = JSON.parse(response.body, symbolize_names: true)

        expect(user_response).to have_key(:data)
        expect(user_response[:data]).to be_a Hash

        expect(user_response[:data]).to have_key(:type)
        expect(user_response[:data][:type]).to be_a String
        expect(user_response[:data][:type]).to eq('user')

        expect(user_response[:data]).to have_key(:id)
        expect(user_response[:data][:id]).to be_a String

        expect(user_response[:data]).to have_key(:attributes)
        expect(user_response[:data][:attributes]).to be_a Hash

        expect(user_response[:data][:attributes]).to have_key(:name)
        expect(user_response[:data][:attributes][:name]).to be_a String
        expect(user_response[:data][:attributes][:name]).to eq(user_params[:name])

        expect(user_response[:data][:attributes]).to have_key(:email)
        expect(user_response[:data][:attributes][:email]).to be_a String
        expect(user_response[:data][:attributes][:email]).to eq(user_params[:email])

        expect(user_response[:data][:attributes]).to have_key(:api_key)
        expect(user_response[:data][:attributes][:api_key]).to be_a String
      end
    end
  end
end
require 'rails_helper'

RSpec.describe "Learning Resources" do
  describe "Fetch Learning Resource" do
    describe "happy paths" do
      it "returns the information for a given country", :vcr do
        get api_v1_learning_resources_path(country: 'singapore')

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:data)

        resource = parsed[:data]

        expect(resource).to have_key(:id)
        expect(resource[:id]).to be(nil)

        expect(resource).to have_key(:type)
        expect(resource[:type]).to eq('learning_resource')

        expect(resource).to have_key(:attributes)
        expect(resource[:attributes]).to be_a Hash

        attributes = resource[:attributes]

        expect(attributes).to_not have_key(:etag)
        expect(attributes).to_not have_key(:kind)

        expect(attributes).to have_key(:country)
        expect(attributes[:country]).to be_a String

        expect(attributes).to have_key(:video)
        expect(attributes[:video]).to be_a Hash

        expect(attributes[:video]).to have_key(:title)
        expect(attributes[:video][:title]).to be_a String

        expect(attributes[:video]).to have_key(:youtube_video_id)
        expect(attributes[:video][:youtube_video_id]).to be_a String

        expect(attributes).to have_key(:images)
        expect(attributes[:images]).to be_an Array

        attributes[:images].each do |image|
          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a String

          expect(image).to have_key(:url)
          expect(image[:url]).to be_a String
        end
      end
    end

    describe "edge cases" do
      it "returns empty objects if no images or video is found", :vcr do
        get api_v1_learning_resources_path(country: 'XXXXYWYWYWYWYWYWBBHFHS')

        expect(response).to be_successful

        learning_resource = JSON.parse(response.body, symbolize_names: true)

        expect(learning_resource).to have_key(:data)
        expect(learning_resource[:data]).to be_a Hash

        expect(learning_resource[:data]).to have_key(:attributes)
        expect(learning_resource[:data][:attributes]).to be_a Hash

        expect(learning_resource[:data][:attributes]).to have_key(:video)
        expect(learning_resource[:data][:attributes][:video]).to eq({})

        expect(learning_resource[:data][:attributes]).to have_key(:images)
        expect(learning_resource[:data][:attributes][:images]).to eq([])
      end
    end
  end
end
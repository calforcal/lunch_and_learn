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

          result = recipes.first[:attributes]

          expect(result[:title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
          expect(result[:url]).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
          expect(result[:country]).to eq("thailand")
          expect(result[:image_url]).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIAGFdoewgbkuXJdKk%2BLjzmXn%2FrCb%2Fm7DQo4KDy48Yap8AiEA6XahBrlKmD6yUdD1m%2BsLV9SJK2Ckv7ubr%2FESb0eSVH4quQUIShAAGgwxODcwMTcxNTA5ODYiDMavzemqM6b1CXxGviqWBT5dMR1QfoaNvYrcJD%2Fw2M4HKDxhoc8Z7qyDOutjxuT38flSxdy898wennuTTFstWqV9UNhRLt1JAmNYyKtTH%2FOxe28Hu%2FzEfEDu4I6XuhoRO36piHjVxEyR9tXV%2BfaDcPSluuYHmZNjZXb%2B5%2FSeQLS5ISIBpZ33wKo3mpUwg%2BJxXIcvUb84JAPrzhOZKkIDSa2%2FTaO1LSXMqYtZPKMNgEDIGoYnROLGDPWju0Xf3yTBk2tVBCpAdpV%2BaGXd4moZDWcTvfUV8FEFfsrYKXtxDibLkWGt%2FAGa4VD1SqXenpOBIC5o%2BwsqqHvTR3oUVsFz1s1boptuCycVC2chFcyDqlRxg2EkBcpG9%2BQmhlrL6Lq9osyujLT2XcMDYqD%2FtqdZTVPP9%2Fpl22yIAj0979HE6nbRvWCrSM6t%2Bekn9bmTk%2FrQpugWcKGr9wONVdYjGspqCUqyceDOk5loh9O4Ep7PupZf51WXm6EAyIgB1SQRey1G3C5vBxEEUjCbYeYbAMh8RtOo9fWtk8LrA2subbtiSLN6aDKKzyrmcIAB7uSIx8vllgPCm2GyIKuPefp%2FPrS5Ad0q08vQ0VkadeL5mC31tF6kiPUqBxbZuNPFUIH32O37XmI%2FKJ5K%2BooriJ7c8Z7eRvhu2B5g7U%2Fzl7AKiAMwS2F7THhn4JUlugoyfkiUGXAXn%2Fj%2BUNsS%2B%2F86wB30romLh2xJRJX8oFpgMC9KAbrWJcY6ZDINJj5EL2gnd80KNEdk3Uu4t4f%2F3TUA%2FIk6LkrusGVnZzRfH69op7KG6%2BUXckaxfQbBUEoynzJI2c0dsItgFhizkuJKNwG753rRqpFX2wO8zSilZdtaDB%2F%2F4OcSOSIB1ustv3d7aZIw6oqknryqd3lKb%2FwoMPv9uaYGOrEBj8erCGmHEV9DDxNY%2BwdOLUz6SyHgnqsl1d9%2BJG41TzlFGtw8C66PGqMCyG%2BPzugIveOfHwZvqAvFV49S0wfGFaFEP6DWn4SDN5gEGP2tbl3NA8AHFq1%2FE8FdyfwI9uomHqIPBkD2J1c%2FBgkbSeGYSJ65RVaxFVASJdIDPWgUFjpdR1Q4zsc2jDl7F%2BjCbSI5KVDYFKvSGlZuotls0OcLr5yACUlxIaHGaXTUVvBAlA6W&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230805T175808Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFBAAFAM42%2F20230805%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=e8e9ff513c4aff57bd9cc553d95b4dd3ce0c8968d28b213dd6bdaf73324eeba3")
        end

        it "returns a random countries recipes if no country is given", :vcr do
          allow_any_instance_of(CountriesFacade).to receive(:countries_index).and_return("thailand")
          recipe = File.read("spec/fixtures/vcr_cassettes/Recipes/Fetch_Recipes/By_Search/thailand_recipes.json")
          stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=2744bd73&app_key=0352aebe74e583579a83bfbd65db7a64&q=thailand&type=public")
          .to_return(status: 200, body: recipe)

          get api_v1_recipes_path(country: '')

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

        describe 'edge cases' do
          it "return an empty array if no results found for country or empty string given", :vcr do
            get api_v1_recipes_path(country: 'XXXXXXXXXXXXXXX')

            expect(response).to be_successful
            
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            recipes = parsed[:data]

            expect(recipes).to be_an Array
            expect(recipes.empty?).to be true
          end
        end
      end
    end
  end
end
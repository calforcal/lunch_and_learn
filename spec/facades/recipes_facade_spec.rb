require 'rails_helper'

RSpec.describe RecipesFacade do
  describe 'Recipe' do
    describe '#recipe_index' do
      it 'can return recipes as objects' do
        country = 'thailand'

        recipes = RecipesFacade.new.recipes_index(country)

        expect(recipes).to be_an Array

        recipes.each do |recipe|
          expect(recipe).to be_a Recipe
          expect(recipe.id).to eq(nil)
          expect(recipe.title).to be_a String
          expect(recipe.url).to be_a String
          expect(recipe.country).to be_a String
          expect(recipe.image_url).to be_a String
        end
      end
    end
  end
end